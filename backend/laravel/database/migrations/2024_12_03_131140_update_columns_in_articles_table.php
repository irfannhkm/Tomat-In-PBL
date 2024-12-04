<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateColumnsInArticlesTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('articles', function (Blueprint $table) {
            $table->string('article_title')->change(); // Menghapus batas panjang 50 karakter
            $table->string('article_url')->change();   // Menghapus batas panjang 100 karakter
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('articles', function (Blueprint $table) {
            $table->string('article_title', 50)->change(); // Mengembalikan batas panjang 50 karakter
            $table->string('article_url', 100)->change();  // Mengembalikan batas panjang 100 karakter
        });
    }
}
