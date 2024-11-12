<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plant extends Model
{
    use HasFactory;

    protected $table = 'plants'; // Mengacu ke tabel plants
    protected $primaryKey = 'id'; // Mengacu ke field id sebagai primary key

    protected $fillable = [
        'user_id',
        'name',
        'description',
        'image',
        'created_at',
        'updated_at',
    ];

    // Relasi satu Plant dimiliki oleh satu AppUser
    public function appUser()
    {
        return $this->belongsTo(AppUser::class, 'user_id');
    }
}

