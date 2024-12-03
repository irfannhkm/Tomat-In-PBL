<?php

namespace Database\Seeders;

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
        // Super admin
        $super_admin = AppUser::create([
            'name' => 'Admin Leafin',
            'username' => 'admin123',
            'email' => 'admin123@gmail.com',
            'password' => bcrypt('admin123'),
            'email_verified_at' => now(),
        ],
        // [
        //     'name'=> 'Admin Tomatin',
        //     'username'=> 'admin_tomatin',
        //     'email'=> 'leafingrowbeyond@gmail.com',
        //     'password'=> bcrypt('admin123'),
        //     'email_verified_at'=> now(),
        // ]
        );
        $super_admin->assignRole('super_admin');

        // Regular user
        $user = AppUser::create([
            'name' => 'user',
            'username' => 'user_tomatin',
            'email' => 'user@gmail.com',
            'password' => bcrypt('user123'),
            'email_verified_at' => now(),
        ]);
        $user->assignRole('User');

        $indonesian_users = [
            ['name' => 'Andi Wijaya', 'username' => 'andi_wijaya', 'email' => 'andi@gmail.com'],
            ['name' => 'Rini Oktavia', 'username' => 'rini_oktavia', 'email' => 'rini@gmail.com'],
            ['name' => 'Budi Santoso', 'username' => 'budi_santoso', 'email' => 'budi@gmail.com'],
            ['name' => 'Siti Aisyah', 'username' => 'siti_aisyah', 'email' => 'siti@gmail.com'],
            ['name' => 'Ahmad Fauzi', 'username' => 'ahmad_fauzi', 'email' => 'ahmad@gmail.com'],
            ['name' => 'Dewi Lestari', 'username' => 'dewi_lestari', 'email' => 'dewi@gmail.com'],
            ['name' => 'Rizky Pratama', 'username' => 'rizky_pratama', 'email' => 'rizky@gmail.com'],
            ['name' => 'Indah Permata', 'username' => 'indah_permata', 'email' => 'indah@gmail.com'],
            ['name' => 'Hendra Saputra', 'username' => 'hendra_saputra', 'email' => 'hendra@gmail.com'],
            ['name' => 'Novi Andriani', 'username' => 'novi_andriani', 'email' => 'novi@gmail.com'],
        ];

        foreach ($indonesian_users as $user) {
            $created_user = AppUser::create([
                'name' => $user['name'],
                'username' => $user['username'],
                'email' => $user['email'],
                'password' => bcrypt('password123'),
                'email_verified_at' => now(),
            ]);
            $created_user->assignRole('User');
        }
    }
}
