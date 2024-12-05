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
        $diseases = Disease::select('id', 'disease_name', 'symptoms', 'cause', 'prevention', 'description', 'image', 'created_at', 'updated_at')
            ->orderBy('id', 'asc') // Order by id
            ->get()
            ->map(function ($disease) {
                $disease->image = $disease->image ? asset('storage/' . $disease->image) : null;
                return $disease;
            });

        return response()->json([
            'success' => true,
            'data' => $diseases,
        ]);
    }

    /**
     * Get details of a single disease by ID.
     */
    public function show($id)
    {
        $disease = Disease::select('id', 'disease_name', 'symptoms', 'cause', 'prevention', 'description', 'image', 'created_at', 'updated_at')
            ->find($id);

        if (!$disease) {
            return response()->json([
                'success' => false,
                'message' => 'Disease not found.',
            ], 404);
        }

        $disease->image = $disease->image ? asset('storage/' . $disease->image) : null;

        return response()->json([
            'success' => true,
            'data' => $disease,
        ]);
    }
}