<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AdminOnly
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        // Memeriksa apakah pengguna terautentikasi dan role_id adalah 1 (admin)
        if (Auth::check() && Auth::user()->role_id === 1) {
            return $next($request);
        }

        // Jika bukan admin, logout dan redirect ke halaman login Filament
        Auth::logout();
        return redirect()->route('filament.auth.login')->with('error', 'You are not authorized to access this page.');
    }
}
