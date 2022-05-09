<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Run extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'distance',
        'vitesse',
        'LatLng',
    ];
    protected $casts = [
        'LatLng' => 'array',
    ];
    public function user(){
        return $this->belongsTo(User::class);
    }
   
}
