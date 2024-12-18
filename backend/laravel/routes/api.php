<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\ArticleController;
use App\Http\Controllers\API\YouTubeVideoController;
use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\LocationController;
use App\Http\Controllers\API\DiseaseController;

Route::prefix('v1')->group(function () {
    Route::prefix('auth')->group(function () {
        Route::controller(AuthController::class)->group(function () {
            Route::post('logout', 'logout')->middleware('auth:sanctum');
            Route::post('login', 'login')->middleware('throttle:login');
            Route::post('register', 'register')->middleware('throttle:register');
            Route::post('google/callback', 'googleCallback');
            Route::post('otp/send', 'sendOTP');
            Route::post('otp/register/send', 'sendOTPRegister');
            Route::post('otp/verify', 'verifyOTP');
            Route::post('change-password', 'changePassword');
            Route::post('change-email', 'changeEmail');
        });
    });

    // Authenticated
    Route::middleware(['auth:sanctum', 'throttle:authenticated'])->group(function () {
        Route::group(['prefix' => 'user'], function () {
            Route::get('/', [UserController::class, 'user']);
            Route::put('/', [UserController::class, 'update']);
            Route::post('avatar', [UserController::class, 'update_avatar']);
            Route::put('change-password', [UserController::class, 'changePassword']);
            Route::post('otp/send', [UserController::class, 'sendOTP']);
        
            //location
            Route::prefix('locations')->group(function () {
                Route::get('/', [LocationController::class, 'index']);
                Route::get('/{id}', [LocationController::class, 'show']);
                Route::post('/', [LocationController::class, 'store']);
                Route::put('/{id}', [LocationController::class, 'update']);
                Route::delete('/{id}', [LocationController::class, 'destroy']);
            });
        });  
    }); // End of Authenticated
}); // End of v1 prefix

// Public routes
Route::get('articles', [ArticleController::class, 'index']);
Route::get('articles/{id}', [ArticleController::class, 'show']);

Route::get('videos', [YouTubeVideoController::class, 'index']);
Route::get('videos/{id}', [YouTubeVideoController::class, 'show']);

Route::get('diseases', [DiseaseController::class, 'index']);
Route::get('diseases/{id}', [DiseaseController::class, 'show']);
Route::get('diseases/class/{class_idx}', [DiseaseController::class, 'showby_classidx']);
