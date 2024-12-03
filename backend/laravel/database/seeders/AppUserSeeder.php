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
        
        $admin = AppUser::create([
            'name' => 'admin',
            'username' => 'admin_tomatin',
            'email' => 'leafingrowbeyond@gmail.com',
            'password' => bcrypt('admin123'), 
            'email_verified_at' => now(),
        ]);

        $user = AppUser::create([
            'name' => 'user',
            'username' => 'user_tomatin',
            'email' => 'user@gmail.com',
            'password' => bcrypt('user123'), 
        ],
    );

        $admin->assignRole('admin');
        $user->assignRole('user');

    }
}
