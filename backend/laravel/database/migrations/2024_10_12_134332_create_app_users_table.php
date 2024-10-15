<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('app_users', function (Blueprint $table) {
            $table->id(); // Menggunakan id() untuk membuat primary key default (id)
            $table->foreignId('role_id')->constrained('roles')->onDelete('cascade'); // Pastikan ini mengacu pada tabel roles
            $table->string('name', 30); // Nama pengguna
            $table->string('email', 30)->unique(); // Email pengguna yang unik
            $table->string('password'); // Password pengguna
            $table->string('google_id', 50)->nullable(); // Google ID, nullable
            $table->string('avatar')->nullable(); // URL avatar, nullable
            $table->timestamps(); // Timestamps untuk created_at dan updated_at
        });
        
        
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('app_users');
    }
};
