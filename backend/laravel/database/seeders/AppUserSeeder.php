<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\AppUser;
use Illuminate\Support\Facades\Hash;

class AppUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        AppUser::create([
            'name' => 'admin',
            'username' => 'admin_tomatin',
            'email' => 'admin@gmail.com',
            'password' => Hash::make('admin123.'), // Menggunakan Hash::make
        ]);

        AppUser::create([
            'name' => 'user',
            'username' => 'user_tomatin',
            'email' => 'user@gmail.com',
            'password' => Hash::make('user12345.'), // Menggunakan Hash::make
        ]);
    }
}
