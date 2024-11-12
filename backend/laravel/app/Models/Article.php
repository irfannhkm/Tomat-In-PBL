<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    use HasFactory;

    protected $table = 'articles'; // Mengacu ke tabel articles

    protected $fillable = [
        'article_title',
        'article_content',
        'article_url',
        'disease_id',
    ];

    // Relasi satu Article dimiliki oleh satu Disease
    public function disease()
    {
        return $this->belongsTo(Disease::class, 'disease_id');
    }

    // Relasi satu Article dimiliki oleh satu AppUser
    public function appUser()
    {
        return $this->belongsTo(AppUser::class, 'user_id');
    }
}

