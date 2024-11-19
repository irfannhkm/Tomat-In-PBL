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
            $table->string('name', 30); // Nama pengguna
            $table->string('username', 30)->unique(); // Username pengguna yang unik
            $table->string('email', 30)->unique(); // Email pengguna yang unik
            $table->string('password'); // Password pengguna
            $table->string('google_id', 50)->nullable(); // Google ID, nullable
            $table->string('avatar')->nullable(); // URL avatar, nullable
            $table->timestamps(); // Timestamps untuk created_at dan updated_at
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });
        
        
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('app_users');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
    }
};
