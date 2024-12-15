<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TreatmentLogs extends Model
{
    use HasFactory;

    // Nama tabel yang dihubungkan dengan model ini
    protected $table = 'treatment_logs';

    // Kolom-kolom yang dapat diisi secara massal
    protected $fillable = [
        'diagnosis_history_id',
        'treatment_type',
        'treatment_date',
        'notes',
    ];

    /**
     * Relasi ke model DiagnosisHistory
     */
    public function diagnosis_history()
    {
        return $this->belongsTo(DiagnosisHistory::class, 'diagnosis_history_id');
    }
    public function user()
    {
        return $this->belongsTo(AppUser::class, 'user_id');
    }
}
