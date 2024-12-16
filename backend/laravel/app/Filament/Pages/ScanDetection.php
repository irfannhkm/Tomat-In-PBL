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
            'image' => 'required|image|max:2048', // Validasi ukuran dan tipe file
        ]);

        try {
            // Kirim gambar ke FastAPI
            $response = Http::attach(
                'file', file_get_contents($this->image->getRealPath()), $this->image->getClientOriginalName()
            )->post(env('FASTAPI_URL'));

            if ($response->successful()) {
                $result = $response->json()['classifications'][0] ?? ['error' => 'Tidak ada deteksi ditemukan.']; // Ambil hasil top-1

                // Cek apakah confidence di bawah 80%
                if (isset($result['top1_confidence']) && $result['top1_confidence'] < 70) {
                    $this->result = [
                        'error' => 'Nilai confidence terlalu rendah, bukan termasuk daun tomat.',
                        'confidence' => $result['top1_confidence'],
                    ];
                    return;
                }

                // Lanjutkan jika confidence memadai
                $id = $result['class_id'];
                $query = Disease::where('class_idx', $id)->first();

                if ($query) {
                    $this->result = $query->toArray();
                    // Append confidence
                    $this->result['confidence'] = $result['top1_confidence'];
                    $this->result['image'] = asset('storage/' . $query->image);
                } else {
                    $this->result = [
                        'error' => 'Kelas ditemukan, tetapi tidak ada data terkait di database.',
                        'confidence' => $result['top1_confidence'],
                    ];
                }
            } else {
                $this->result = ['error' => 'Deteksi gagal dilakukan.'];
            }
        } catch (\Exception $e) {
            $this->result = ['error' => 'Terjadi kesalahan sistem => ' . $e->getMessage()];
        }
    }
}
