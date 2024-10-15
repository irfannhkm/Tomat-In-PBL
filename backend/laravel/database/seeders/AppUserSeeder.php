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
            'email' => 'admin@gmail.com',
            'password' => Hash::make('admin'), // Menggunakan Hash::make
            'role_id' => 1, // Jika Anda menggunakan role_id
        ]);

        AppUser::create([
            'name' => 'user',
            'email' => 'user@gmail.com',
            'password' => Hash::make('user'), // Menggunakan Hash::make
            'role_id' => 2, // Jika Anda menggunakan role_id
        ]);
    }
}
