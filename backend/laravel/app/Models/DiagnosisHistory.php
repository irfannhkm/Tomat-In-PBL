<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DiagnosisHistory extends Model
{
    use HasFactory;

    protected $table = 'diagnosis_history'; // Mengacu ke tabel diagnosis_history

    // Relasi satu DiagnosisHistory dimiliki oleh satu AppUser
    public function appUser()
    {
        return $this->belongsTo(AppUser::class, 'user_id');
    }

    // Relasi satu DiagnosisHistory dimiliki oleh satu Disease
    public function disease()
    {
        return $this->belongsTo(Disease::class, 'disease_id');
    }
}
