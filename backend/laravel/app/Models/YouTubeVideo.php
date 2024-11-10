<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class YouTubeVideo extends Model
{
    use HasFactory;

    // Nama tabel yang dihubungkan dengan model ini
    protected $table = 'youtube_videos';

    // Kolom-kolom yang dapat diisi secara massal
    protected $fillable = [
        'video_title',
        'video_url',
        'disease_id'       
    ];

    /**
     * Aturan casting untuk tipe data pada kolom tertentu
     */
    protected $casts = [
        'published_at' => 'datetime',
    ];

    // Relasi satu YouTubeVideo memiliki satu Disease
    public function disease()
    {
        return $this->belongsTo(Disease::class);
    }
}
