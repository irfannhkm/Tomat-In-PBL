<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Support\Facades\RateLimiter;
use Request;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // RateLimiter::for('login', function (Request $request) {
        //     return Limit::perMinute(5)->by($request->ip());
        // });
    
        // RateLimiter::for('register', function (Request $request) {
        //     return Limit::perMinute(3)->by($request->ip());
        // });
    
        // RateLimiter::for('authenticated', function (Request $request) {
        //     return $request->user()
        //         ? Limit::perMinute(60)->by($request->user()->id)
        //         : Limit::perMinute(30)->by($request->ip());
        // });
    }
}
