<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Location extends Model
{
    use HasFactory;

    protected $table = 'locations'; // Mengacu ke tabel locations

    protected $fillable = ['user_id', 'location_name', 'latitude', 'longitude'];

    // Relasi satu Location dimiliki oleh satu AppUser
    public function appUser()
    {
        return $this->belongsTo(AppUser::class, 'user_id');
    }
}
