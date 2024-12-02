<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Support\Facades\Storage;


class AppUser extends Authenticatable
{
    use HasFactory, HasRoles, Notifiable, HasApiTokens;

    protected $table = 'app_users'; 
    protected $fillable = [
        'username',
        'name',
        'email',
        'password',
        'google_id',
        'email_verified_at',
        'avatar',
    ];
        /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

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

    // Relasi satu AppUser memiliki banyak Article
    public function articles()
    {
        return $this->hasMany(Article::class, 'user_id');
    }
}
