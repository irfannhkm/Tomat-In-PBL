<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DiagnosisHistory extends Model
{
    use HasFactory;

    protected $table = 'diagnosis_history';

    protected $fillable = [
        'id',
        'user_id',
        'disease_id',
        'image',
        'diagnosis_date',
    ];

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
