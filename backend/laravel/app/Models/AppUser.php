<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class AppUser extends Authenticatable
{
    use HasFactory;

    protected $table = 'app_users'; // Mengacu ke tabel app_users
    // Tidak perlu mendefinisikan $primaryKey jika menggunakan default 'id'

    // Menentukan kolom yang dapat diisi secara massal
    protected $fillable = [
        'name',
        'email',
        'password',
        'google_id',
        'avatar',
        'role_id', // Pastikan juga menyertakan role_id jika digunakan
    ];

    // Relasi satu AppUser memiliki satu Location
    public function location()
    {
        return $this->hasOne(Location::class, 'user_id');
    }

    // Relasi satu AppUser memiliki banyak DiagnosisHistory
    public function diagnosisHistories()
    {
        return $this->hasMany(DiagnosisHistory::class, 'user_id');
    }

    // Relasi satu AppUser memiliki banyak Plant
    public function plants()
    {
        return $this->hasMany(Plant::class, 'user_id');
    }

    // Relasi satu AppUser memiliki banyak Article
    public function articles()
    {
        return $this->hasMany(Article::class, 'user_id');
    }

    // Relasi satu AppUser memiliki satu Role
    public function role()
    {
        return $this->belongsTo(Role::class, 'role_id', 'id'); // Pastikan relasi ini sesuai
    }
}
