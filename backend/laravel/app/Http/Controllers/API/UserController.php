<?php

namespace App\Http\Controllers\API;

use App\Models\AppUser;
use App\Services\OTPService;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\API\BaseController;

class UserController extends BaseController
{
    protected $otpService;

    public function __construct(OTPService $otpService)
    {
        $this->otpService = $otpService;
    }

    /**
     * Get the authenticated user.
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse|\Illuminate\Http\Response
     */
    public function user(Request $request)
    {
        return $this->sendResponse($request->user(), "Berhasil mengambil data user.");
    }

    /**
     * Update the authenticated user.
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse|\Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $user = $request->user();
        $messages = [
            'name.string' => 'Nama harus berupa teks.',
            'name.max' => 'Nama tidak boleh lebih dari 255 karakter.',
            'email.email' => 'Email harus berupa alamat email yang valid.',
            'email.max' => 'Email tidak boleh lebih dari 255 karakter.',
            'email.unique' => 'Email sudah terdaftar.',
            'username.string' => 'Username harus berupa teks.',
            'username.max' => 'Username tidak boleh lebih dari 255 karakter.',
            'username.unique' => 'Username sudah terdaftar.',
        ];

        // Validate the request
        try {
            $validatedData = $request->validate([
                'name' => 'string|max:255',
                'email' => 'email|max:255|unique:users,email,' . $user->id,
                'username' => 'string|max:255|unique:users,username,' . $user->id,
            ], $messages);
        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage(), $th->getCode());
        }

        // Update the user with validated data
        $user->update($validatedData);

        return $this->sendResponse($user, "Berhasil mengupdate data user.");
    }

    /**
     * Update the authenticated user's avatar.
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse|\Illuminate\Http\Response
     */
    public function update_avatar(Request $request)
    {
        try {
            $request->validate([
                'avatar' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
            ], [
                'avatar.required' => 'Avatar tidak boleh kosong.',
                'avatar.image' => 'Avatar harus berupa gambar.',
                'avatar.mimes' => 'Avatar harus berformat jpeg, png, jpg, atau gif.',
                'avatar.max' => 'Ukuran avatar tidak boleh lebih dari 2MB.',
            ]);
        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage(), $th->getCode(), 400);
        }
    
        $user = $request->user();
    
        // Simpan file langsung di direktori storage/
        $fileName = uniqid() . '.' . $request->file('avatar')->getClientOriginalExtension();
        $path = $request->file('avatar')->storeAs('', $fileName, 'public');
    
        // Hapus avatar lama jika ada
        if ($user->avatar) {
            Storage::disk('public')->delete($user->avatar);
        }
    
        // Perbarui path avatar pengguna
        $user->avatar = $path;
        $user->save();
    
        return $this->sendResponse($user, "Berhasil mengupdate avatar.");
    }
    

    /**
     * Change the authenticated user's password.
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse|\Illuminate\Http\Response
     */
    public function changePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'old_password' => 'required',
            'new_password' => 'required',
        ], [
            'old_password.required' => 'Password lama harus diisi.',
            'new_password.required' => 'Password baru harus diisi.',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }

        $user = $request->user();

        // Check if the old password is correct
        if (!Hash::check($request->input('old_password'), $user->password)) {
            return $this->sendError('Validation Error.', ['old_password' => 'Password lama tidak sesuai.'], 409);
        }

        // Update the user's password
        $user->password = Hash::make($request->input('new_password'));
        $user->save();

        return $this->sendResponse([], 'Password berhasil diubah.');
    }

    /**
     * sendOTP for change email.
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse|mixed
     */
    public function sendOTP(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors(), 409);
        }

        if (AppUser::where('email', $request->email)->exists()) {
            return $this->sendError('Email sudah terdaftar', null, 409);
        }

        $this->otpService->generateOTP($request->email);
        return $this->sendResponse([], 'OTP berhasil dikirim, cek email anda.');
    }
    
}
