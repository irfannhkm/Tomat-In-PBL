<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\DiagnosisHistory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class DiagnosisHistoryController extends Controller
{
    /**
     * API untuk deteksi tanpa login.
     * Mengembalikan hasil diagnosis tanpa menyimpan ke database.
     */
    public function detect(Request $request)
    {
        $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        // Simulasi proses deteksi penyakit
        $imagePath = $request->file('image')->store('uploads/detections', 'public');
        $detectedDisease = [
            'disease_name' => 'Tomato Leaf Spot',
            'confidence' => 98.5,
            'description' => 'Penyakit yang sering menyerang daun tomat. Segera lakukan penyemprotan fungisida.',
        ];

        return response()->json([
            'success' => true,
            'message' => 'Disease detection successful.',
            'data' => [
                'image_url' => Storage::url($imagePath),
                'detection' => $detectedDisease,
            ],
        ]);
    }

    /**
     * API untuk menambahkan diagnosis ke halaman My Plants.
     * Hanya untuk pengguna yang sudah login.
     */
    public function store(Request $request)
    {
        $request->validate([
            'disease_id' => 'required|exists:diseases,id',
            'media_type' => 'required|string',
            'media_size' => 'required|string',
            'name_plant' => 'nullable|string|max:100',
            'diagnosis_date' => 'required|date',
            'image' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        $user = Auth::user();

        // Simpan gambar
        $imagePath = $request->file('image')->store('uploads/diagnoses', 'public');

        // Simpan data diagnosis
        $diagnosisHistory = DiagnosisHistory::create([
            'user_id' => $user->id,
            'disease_id' => $request->disease_id,
            'media_type' => $request->media_type,
            'media_size' => $request->media_size,
            'name_plant' => $request->name_plant,
            'diagnosis_date' => $request->diagnosis_date,
            'image' => $imagePath,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Diagnosis added to My Plants successfully.',
            'data' => $diagnosisHistory,
        ]);
    }
}
