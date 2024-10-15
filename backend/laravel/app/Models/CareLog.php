<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CareLog extends Model
{
    use HasFactory;

    // Nama tabel yang dihubungkan dengan model ini
    protected $table = 'care_logs';

    // Kolom-kolom yang dapat diisi secara massal
    protected $fillable = [
        'plant_id',
        'user_id',
        'care_type',
        'description',
        'date',
    ];

    /**
     * Relasi ke model Plant
     */
    public function plant()
    {
        return $this->belongsTo(Plant::class, 'plant_id');
    }

    /**
     * Relasi ke model AppUser
     */
    public function user()
    {
        return $this->belongsTo(AppUser::class, 'user_id');
    }
}
