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
        
        $super_admin = AppUser::create([
            'name' => 'admin',
            'username' => 'admin_tomatin',
            'email' => 'leafinrowbeyond@gmail.com',
            'password' => bcrypt('admin123'), // Menggunakan Hash::make
        ]);

        $super_admin->assignRole('super_admin');

    }
}
