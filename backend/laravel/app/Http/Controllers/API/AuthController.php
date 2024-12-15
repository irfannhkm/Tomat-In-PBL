<?php

namespace App\Http\Controllers\API;

use App\Models\AppUser;
use App\Services\OTPService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Str;
use Illuminate\Support\Facades\Validator;

class AuthController extends BaseController
{
    protected $otpService;
    public function __construct(OTPService $otpService)
    {
        $this->otpService = $otpService;
    }
    /**
     * Login api
     * @param \Illuminate\Http\Request $request
     * @return mixed|\Illuminate\Http\JsonResponse
     */
    public function login(Request $request): JsonResponse
    {
        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
            $user = Auth::user();
            $success['token'] = $user->createToken('api-token')->plainTextToken;
            $success['user'] = $user;


            return $this->sendResponse($success, 'User login successfully.');
        } else {
            return $this->sendError('Unauthorized.', ['error' => 'Unauthorized'], 401);
        }
    }

    /**
     * Register api
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required',
            'name' => 'required',
            'email' => 'required|email',
            'password' => 'required',
            'c_password' => 'required|same:password',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }

        $input = $request->all();
        if (AppUser::where('email', $input['email'])->exists()) {
            return $this->sendError('Validation Error.', ['error' => 'Email already exists']);
        }
        $input['password'] = bcrypt($input['password']);
        $user = AppUser::create($input);

        // Berikan role 'user' secara otomatis
        $this->assignUserRole($user, 'User');
        $success['token'] = $user->createToken('api-token')->plainTextToken;
        $success['name'] = $user->name;

        $user->email_verified_at = now();
        $user->save();

        return $this->sendResponse($success, 'User register successfully.');
    }

    /**
     * Summary of googleCallback
     * @param \Illuminate\Http\Request $request
     * @return mixed|\Illuminate\Http\JsonResponse
     */
    public function googleCallback(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'google_id'=> 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }
        // Check if the user already exists
        $existingUser = AppUser::where('google_id', $request->id)
            ->orWhere('email', $request->email)
            ->first();

        if ($existingUser) {
            // If the user exists, log them in without updating their information
            Auth::login($existingUser);

            $user = Auth::user();
            $success['token'] = $user->createToken('api-token')->plainTextToken;
            $success['name'] = $user->name;
            return $this->sendResponse($success, 'User login successfully.');
        }

        // If the user does not exist, create a new user
        $user = AppUser::create([
            'google_id' => $request->id,
            'name' => $request->displayName,
            'email' => $request->email,
            'password' => Str::random(12),
            'email_verified_at' => now(),
            'avatar' => $request->photoUrl,
        ]);

        $this->assignUserRole($user, 'user');

        Auth::login($user);

        $user = Auth::user();
        $success['token'] = $user->createToken('api-token')->plainTextToken;
        $success['name'] = $user->name;
        return $this->sendResponse($success, 'User login successfully.');
    }

    /**
     * logout api
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return $this->sendResponse([], 'User logged out successfully.');
    }

    /**
     * sendOTP
     * @param \Illuminate\Http\Request $request
     * @return JsonResponse|mixed
     */
    public function sendOTP(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
        ]);
        
        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }
        
        if (!AppUser::where('email', $request->email)->exists()) {
            return $this->sendError('Validation Error.', ['error' => 'Email tidak terdaftar'], 409);
        }
        try {
            $this->otpService->generateOTP($request->email);
            
        } catch (\Throwable $th) {
            return $this->sendError('Validation Error.', $th->getMessage());
        }
        
        return $this->sendResponse([], 'OTP berhasil dikirim, cek email anda.');
    }
    public function sendOTPRegister(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }

        try {
            $this->otpService->generateOTP($request->email);
        } catch (\Throwable $th) {
            return $this->sendError('Validation Error.', $th->getMessage());
        }
        return $this->sendResponse([], 'OTP berhasil dikirim, cek email anda. Lalu lakukan verifikasi.');
    }
    /**
     * verifyOTP
     * @param \Illuminate\Http\Request $request
     * @return JsonResponse|mixed
     */
    public function verifyOTP(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'otp' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }

        $isValid = $this->otpService->verifyOTP($request->email, $request->otp);

        if ($isValid) {
            return $this->sendResponse([], 'OTP valid.');
        } else {
            return $this->sendError('Validation Error.', ['error' => 'OTP tidak valid'], 409);
        }
    }

    public function changePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'token' => 'required',
            'password' => 'required',
            'c_password' => 'required|same:password',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }

        $token = $request->input('token');
        $userToken = $this->otpService->getTokenByEmail($request->email);

        if ($userToken != $token) {
            return $this->sendError('Validation Error', 'Token tidak valid', 409);
        }

        $user = AppUser::where('email', $request->email)->first();
        if (!$user) {
            return $this->sendError('Validation Error.', ['error' => 'Email tidak terdaftar'], 409);
        }

        $user->password = bcrypt($request->password);
        $user->save();

        return $this->sendResponse([], 'Password berhasil diubah.');
    }
    public function changeEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'token' => 'required',
        ]);
        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }
        $token = $request->input('token');
        $userToken = $this->otpService->getTokenByEmail($request->email);
        if ($userToken != $token) {
            return $this->sendError('Validation Error', 'Token tidak valid', 409);
        }
        $user = AppUser::where('email', $request->email)->first();
        if (!$user) {
            return $this->sendError('Validation Error.', ['error' => 'Email tidak terdaftar'], 409);
        }
        $user->email = $request->email;
        $user->save();
        return $this->sendResponse([], 'Email berhasil diubah.');
    }
}