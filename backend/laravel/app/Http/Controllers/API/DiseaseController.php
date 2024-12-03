<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Disease;
use Illuminate\Http\Request;

class DiseaseController extends Controller
{
    // Menampilkan semua penyakit
    public function index()
    {
        return response()->json(Disease::all(), 200);
    }

    // Menampilkan detail penyakit berdasarkan ID
    public function show($id)
    {
        $disease = Disease::find($id);

        if (!$disease) {
            return response()->json(['message' => 'Disease not found'], 404);
        }

        return response()->json($disease, 200);
    }
}
