<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\ArticleController;
use App\Http\Controllers\API\YouTubeVideoController;
use App\Http\Controllers\API\LocationController;
use App\Http\Controllers\API\DiagnosisHistoryController;

Route::post('/login', [AuthController::class, 'login']);

// Public routes
Route::get('articles', [ArticleController::class, 'index']);
Route::get('articles/{id}', [ArticleController::class, 'show']);

Route::get('videos', [YouTubeVideoController::class, 'index']);
Route::get('videos/{id}', [YouTubeVideoController::class, 'show']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('locations', [LocationController::class, 'index']); // List all locations
    Route::get('locations/{id}', [LocationController::class, 'show']); // Get single location
    Route::post('locations', [LocationController::class, 'store']); // Create new location
    Route::put('locations/{id}', [LocationController::class, 'update']); // Update location
    Route::delete('locations/{id}', [LocationController::class, 'destroy']); // Delete location
});


Route::group(['prefix' => 'diagnosis'], function () {
    // API tanpa login
    Route::post('/detect', [DiagnosisHistoryController::class, 'detect']);

    // API dengan login
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/store', [DiagnosisHistoryController::class, 'store']);
    });
});


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
