<?php

namespace App\Filament\Pages;

use App\Models\Disease;
use Filament\Pages\Page;
use Illuminate\Support\Facades\Http;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;

class ScanDetection extends Page
{
    use HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-camera';
    protected static ?string $navigationGroup = 'Detection';
    protected static string $view = 'filament.pages.scan-detection';

    public $image;
    public $result;

    public function detect()
    {
        $this->validate([
            'image' => 'required|image|max:2048', // Validasi tipe file dan ukuran gambar
        ]);

        try {
            // Kirim gambar ke FastAPI (endpoint /detect-segment/)
            $response = Http::attach(
                'file', file_get_contents($this->image->getRealPath()), $this->image->getClientOriginalName()
            )->post(env('FASTAPI_SEGMENT_URL')); // Ambil URL dari .env

            if ($response->successful()) {
                $data = $response->json();

                // Jika daun tomat terdeteksi
                if ($data['success'] && $data['is_tomato_leaf']) {
                    $details = $data['details'];

                    // Periksa nilai segmentation_confidence
                    $segmentationConfidence = $details['segmentation']['confidence'];

                    if ($segmentationConfidence < 78) {
                        // Jika segmentation_confidence < 78, berikan pesan bahwa itu bukan daun tomat
                        $this->result = [
                            'error' => 'Confidence terlalu rendah. Kemungkinan besar ini bukan daun tomat.',
                            'segmentation_confidence' => $segmentationConfidence,
                            'is_tomato_leaf' => false,
                        ];
                        return;
                    }

                    // Ambil informasi klasifikasi dari FastAPI
                    $classification = $details['classification'];
                    $classId = $classification['class_id'];
                    $top1Label = $classification['top1_label'];
                    $top1Confidence = $classification['top1_confidence'];

                    // Ambil data penyakit dari database menggunakan class_id
                    $disease = Disease::where('class_idx', $classId)->first();

                    if ($disease) {
                        // Jika penyakit ditemukan di database
                        $this->result = [
                            'disease_name' => $disease->disease_name,
                            'description' => $disease->description,
                            'symptoms' => $disease->symptoms,
                            'prevention' => $disease->prevention,
                            'cause' => $disease->cause,
                            'image' => asset('storage/' . $disease->image),
                            'bounding_box' => $details['bounding_box'],
                            'shape' => $details['shape'],
                            'segmentation_confidence' => $segmentationConfidence,
                            'classification' => [
                                'label' => $top1Label,
                                'confidence' => $top1Confidence
                            ],
                            'segments_x' => $details['segmentation']['segments_x'],
                            'segments_y' => $details['segmentation']['segments_y'],
                        ];
                    } else {
                        // Jika penyakit tidak ada di database
                        $this->result = [
                            'disease_name' => 'Penyakit tidak ditemukan di database.',
                            'bounding_box' => $details['bounding_box'],
                            'shape' => $details['shape'],
                            'segmentation_confidence' => $segmentationConfidence,
                            'classification' => [
                                'label' => $top1Label,
                                'confidence' => $top1Confidence
                            ],
                            'segments_x' => $details['segmentation']['segments_x'],
                            'segments_y' => $details['segmentation']['segments_y'],
                        ];
                    }
                } else {
                    // Jika daun tomat tidak terdeteksi
                    $this->result = [
                        'error' => $data['message'],
                        'is_tomato_leaf' => false,
                    ];
                }
            } else {
                $this->result = ['error' => 'Deteksi gagal dilakukan.'];
            }
        } catch (\Exception $e) {
            // Tangani error sistem
            $this->result = ['error' => 'Terjadi kesalahan sistem => ' . $e->getMessage()];
        }
    }
}
