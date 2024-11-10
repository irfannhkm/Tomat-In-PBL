<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateUsersAndAddSupportTables extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Tambah kolom username unik ke tabel app_users jika belum ada
        Schema::table('app_users', function (Blueprint $table) {
            if (!Schema::hasColumn('app_users', 'username')) {
                $table->string('username', 30)->unique()->after('id')->nullable(); // pastikan urutan kolom sesuai kebutuhan Anda
            }
        });

        // Buat tabel password_reset_tokens jika belum ada
        if (!Schema::hasTable('password_reset_tokens')) {
            Schema::create('password_reset_tokens', function (Blueprint $table) {
                $table->string('email')->primary();
                $table->string('token');
                $table->timestamp('created_at')->nullable();
            });
        }

        // Buat tabel sessions jika belum ada
        if (!Schema::hasTable('sessions')) {
            Schema::create('sessions', function (Blueprint $table) {
                $table->string('id')->primary();
                $table->foreignId('user_id')->nullable()->index();
                $table->string('ip_address', 45)->nullable();
                $table->text('user_agent')->nullable();
                $table->longText('payload');
                $table->integer('last_activity')->index();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Hapus tabel password_reset_tokens jika ada
        if (Schema::hasTable('password_reset_tokens')) {
            Schema::dropIfExists('password_reset_tokens');
        }

        // Hapus tabel sessions jika ada
        if (Schema::hasTable('sessions')) {
            Schema::dropIfExists('sessions');
        }

        // Drop kolom username di tabel app_users jika perlu
        Schema::table('app_users', function (Blueprint $table) {
            if (Schema::hasColumn('app_users', 'username')) {
                $table->dropColumn('username');
            }
        });
    }
}
