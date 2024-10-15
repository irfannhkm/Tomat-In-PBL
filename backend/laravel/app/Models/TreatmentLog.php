<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TreatmentLog extends Model
{
    use HasFactory;

    // Nama tabel yang dihubungkan dengan model ini
    protected $table = 'treatment_logs';

    // Kolom-kolom yang dapat diisi secara massal
    protected $fillable = [
        'diagnosis_id',
        'user_id',
        'treatment_type',
        'description',
        'date',
    ];

    /**
     * Relasi ke model DiagnosisHistory
     */
    public function diagnosis()
    {
        return $this->belongsTo(DiagnosisHistory::class, 'diagnosis_id');
    }

    /**
     * Relasi ke model AppUser
     */
    public function user()
    {
        return $this->belongsTo(AppUser::class, 'user_id');
    }
}
