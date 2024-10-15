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
        Schema::create('youtube_videos', function (Blueprint $table) {
            $table->id(); // Primary key untuk tabel youtube
            $table->foreignId('disease_id')->constrained('diseases')->onDelete('cascade'); 
            $table->string('video_title', 50);
            $table->string('video_url', 100);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('youtube_videos');
    }
};
