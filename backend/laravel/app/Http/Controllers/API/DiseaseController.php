<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Disease;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class DiseaseController extends Controller
{
    /**
     * Get a list of all diseases.
     */
    public function index()
    {
        $diseases = Disease::select('id', 'disease_name', 'symptoms', 'cause', 'prevention', 'description', 'image', 'class_idx', 'created_at', 'updated_at')
            ->orderBy('id', 'asc') // Order by id
            ->get()
            ->map(function ($disease) {
                $disease->image = $disease->image ? asset('storage/' . $disease->image) : null;
                return $disease;
            });

        return response()->json([
            'success' => true,
            'message' => 'Penyakit berhasil ditemukan.',
            'data' => $diseases,
        ]);
    }

    /**
     * Get details of a single disease by ID.
     */
    public function show($id)
    {
        $disease = Disease::find($id);

        if (!$disease) {
            return response()->json([
                'success' => false,
                'message' => 'Penyakit tidak ditemukan.',
            ], 404);
        }

        $disease->image = $disease->image ? asset('storage/' . $disease->image) : null;

        return response()->json([
            'success' => true,
            'message'=> 'Penyakit berhasil ditemukan.',
            'data' => $disease,
        ]);
    }
    public function showby_classidx($class_idx)
    {
        $disease = Disease::where('class_idx','=', $class_idx)->first();

        if (!$disease) {
            return response()->json([
                'success' => false,
                'message' => 'Penyakit tidak ditemukan.',
            ], 404);
        }

        $disease->image = $disease->image ? asset('storage/' . $disease->image) : null;

        return response()->json([
            'success' => true,
            'message'=> 'Penyakit berhasil ditemukan.',
            'data' => $disease,
        ]);
    }
}