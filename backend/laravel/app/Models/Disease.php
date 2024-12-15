<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Disease extends Model
{
    use HasFactory;

    protected $table = 'diseases'; // Mengacu ke tabel diseases
    protected $primaryKey = 'id'; // Primary key adalah disease_id
    protected $fillable = [
        'disease_name',
        'image',
        'description',
        'symptoms',
        'prevention',
        'cause',
        'class_idx',
    ];

    // Relasi satu Disease memiliki banyak DiagnosisHistory
    public function diagnosisHistories()
    {
        return $this->hasMany(DiagnosisHistory::class, 'disease_id');
    }

    // Relasi satu Disease memiliki banyak Article
    public function articles()
    {
        return $this->hasMany(Article::class, 'disease_id');
    }
    public function youTubeVideos()
    {
        return $this->hasMany(YouTubeVideo::class, 'disease_id');
    }
}

