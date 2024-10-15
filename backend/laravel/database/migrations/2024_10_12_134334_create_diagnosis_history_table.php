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
        Schema::create('diagnosis_history', function (Blueprint $table) {
            $table->id(); // Primary key for diagnosis history
            $table->foreignId('user_id')->constrained('app_users')->onDelete('cascade'); // Correct foreign key reference
            $table->foreignId('disease_id')->constrained('diseases')->onDelete('cascade');  // Mengacu pada tabel diseases
            $table->string('image');
            $table->date('diagnosis_date');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('diagnosis_history');
    }
};
