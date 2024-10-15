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
        'symptoms',
        'prevention',
        'description',
        'cause',
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
}

