<?php

use Illuminate\Support\Facades\Route;

// Route::get('/admin/login', function () {
//     return redirect('/admin/login');
// });

// Rute untuk halaman utama
Route::get('/', function () {
    return view('landing.index'); // Menampilkan halaman utama
})->name('home');

// // Rute login Filament tetap diarahkan ke /admin/login
// Route::get('/admin/login', function () {
//     return view('/admin/login');
// })->name('filament.login');