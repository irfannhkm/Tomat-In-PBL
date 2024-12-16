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
        Schema::table('app_users', function (Blueprint $table) {
            $table->string('name')->change(); 
            $table->string('username')->change();
            $table->string('email')->change();
            $table->string('google_id')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('app_users', function (Blueprint $table) {
            $table->dropColumn('name');
            $table->dropColumn('username');
            $table->dropColumn('email');
            $table->dropColumn('google_id');
        });
    }
};
