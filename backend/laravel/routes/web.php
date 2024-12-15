<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LandingPageController;

// Rute untuk halaman utama
Route::get('/', [LandingPageController::class, 'index'])->name('home');

// Rute untuk menangani pengiriman pesan
Route::post('/send-message', [LandingPageController::class, 'sendMessage'])->name('contact.send');
