<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Disease; // Pastikan model Disease sudah ada

class DiseasesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Data untuk penyakit pada tanaman tomat
        $diseases = [
            [
                'disease_name' => 'Bacterial Spot (Xanthomonas campestris pv. vesicatoria)',
                'symptoms' => 'Bercak hitam atau coklat pada daun, batang, dan buah.',
                'prevention' => 'Rotasi tanaman dan menjaga kebersihan alat pertanian.',
                'description' => 'Bacterial Spot adalah penyakit bakteri yang menyebabkan bercak.',
                'cause' => 'Ditularkan oleh air hujan dan alat pertanian yang terkontaminasi.',
                'class_idx'=> '0',
            ],
            [
                'disease_name' => 'Early Blight (Alternaria solani)',
                'symptoms' => 'Bercak hitam dengan lingkaran konsentris pada daun yang lebih tua.',
                'prevention' => 'Pengendalian gulma dan menjaga kelembapan tanah.',
                'description' => 'Early Blight adalah penyakit jamur yang menyebabkan bercak hitam.',
                'cause' => 'Suhu hangat dan kelembapan yang mendukung penyebaran.',
                'class_idx'=> '1',
            ],
            [
                'disease_name' => 'Late Blight (Phytophthora infestans)',
                'symptoms' => 'Bercak basah keabu-abuan di daun dan batang, layu dan mati.',
                'prevention' => 'Hindari kelembapan yang tinggi dan rotasi tanaman.',
                'description' => 'Late Blight adalah penyakit serius yang disebabkan oleh jamur air.',
                'cause' => 'Kelembapan tinggi dan suhu dingin meningkatkan penyebarannya.',
                'class_idx'=> '2',
            ],
            [
                'disease_name' => 'Leaf Mold (Passalora fulva)',
                'symptoms' => 'Daun bagian bawah ditutupi oleh jamur berwarna hijau-zaitun sampai kecoklatan.',
                'prevention' => 'Menjaga sirkulasi udara dan menghindari penyiraman dari atas.',
                'description' => 'Leaf Mold adalah penyakit jamur yang terjadi di lingkungan lembab.',
                'cause' => 'Lingkungan lembab yang meningkatkan pertumbuhan jamur.',
                'class_idx'=> '3',
            ],
            [
                'disease_name' => 'Septoria Leaf Spot (Septoria lycopersici)',
                'symptoms' => 'Bercak kecil berwarna abu-abu atau coklat dengan tepi gelap pada daun.',
                'prevention' => 'Menghindari kelembapan berlebih dan menjaga sirkulasi udara.',
                'description' => 'Septoria Leaf Spot adalah penyakit jamur yang menyebabkan bercak kecil.',
                'cause' => 'Kelembapan tinggi dan sirkulasi udara yang buruk.',
                'class_idx'=> '4',
            ],
            [
                'disease_name' => 'Spider Mites - Two-spotted Spider Mite (Tetranychus urticae)',
                'symptoms' => 'Daun kuning, kering, dan rontok.',
                'prevention' => 'Mengendalikan populasi kutu laba-laba dengan pestisida yang tepat.',
                'description' => 'Kutu laba-laba dua bintik adalah hama kecil yang menyedot cairan dari daun.',
                'cause' => 'Serangan hama kecil yang menyedot getah tanaman.',
                'class_idx'=> '5',
            ],
            [
                'disease_name' => 'Target Spot (Corynespora cassiicola)',
                'symptoms' => 'Bercak pada daun dengan lingkaran berlapis-lapis seperti target panah, daun mati dan rontok.',
                'prevention' => 'Menjaga kelembapan dan sirkulasi udara yang baik.',
                'description' => 'Target Spot adalah penyakit jamur yang menyebabkan bercak pada daun.',
                'cause' => 'Ditekan oleh kelembapan tinggi dan suhu hangat.',
                'class_idx'=> '6',
            ],
            [
                'disease_name' => 'Tomato Yellow Leaf Curl Virus (TYLCV)',
                'symptoms' => 'Daun menggulung, menguning, dan mengerdilkan tanaman.',
                'prevention' => 'Pengendalian kutu putih (whitefly) secara efektif.',
                'description' => 'Virus ini ditularkan oleh serangga kutu putih.',
                'cause' => 'Ditularkan oleh kutu putih yang terinfeksi.',
                'class_idx'=> '7',
            ],
            [
                'disease_name' => 'Tomato Mosaic Virus (TMV)',
                'symptoms' => 'Perubahan warna daun menjadi belang-belang kuning-hijau, daun yang berkerut, dan pertumbuhan tanaman yang terhambat.',
                'prevention' => 'Hindari penyebaran melalui sentuhan manusia, alat pertanian, dan serangga.',
                'description' => 'Tomato Mosaic Virus adalah penyakit yang disebabkan oleh virus yang sangat menular pada tanaman tomat.',
                'cause' => 'Ditularkan oleh alat pertanian, manusia, dan serangga.',
                'class_idx'=> '8',
            ],
            [
                'disease_name' => 'Tomato Healthy',
                'symptoms' => 'Tanaman dalam kondisi sehat, daun hijau cerah.',
                'prevention' => 'Perawatan rutin dan pemeliharaan tanaman yang baik.',
                'description' => 'Tanaman tomat dalam kondisi sehat, tanpa infeksi penyakit atau hama.',
                'cause' => 'Tidak ada infeksi atau hama.',
                'class_idx'=> '9',
            ],
        ];

        // Menyimpan data ke dalam tabel diseases
        foreach ($diseases as $disease) {
            Disease::create($disease);
        }
    }
}
