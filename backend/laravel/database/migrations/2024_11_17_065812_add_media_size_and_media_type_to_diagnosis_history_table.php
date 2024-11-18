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
        Schema::table('diagnosis_history', function (Blueprint $table) {
            $table->string('media_type')->nullable()->after('image');
            $table->string('media_size')->nullable()->after('media_type');
            $table->string('name_plant')->nullable()->after('diagnosis_date');
        });
    }

    public function down(): void
    {
        Schema::table('diagnosis_history', function (Blueprint $table) {
            $table->dropColumn(['media_type', 'media_size', 'name_plant']); // Hapus kolom yang ditambahkan
        });
    }
};
