<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Article;
use App\Models\Disease;

class ArticleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Article::create([
            'article_title' => 'Mengatasi Bacterial Spot pada Tanaman Tomat',
            'article_content' => 'Bacterial Spot adalah penyakit bakteri yang menyebabkan bercak hitam atau coklat pada daun, batang, dan buah. Untuk mengendalikannya, lakukan rotasi tanaman dan jaga kebersihan alat pertanian.',
            'article_url' => 'https://www.vegetables.cornell.edu/pest-management/disease-factsheets/managing-tomato-diseases-successfully/',
            'disease_id' => 1,
            'image_cover' => 'path/to/image_bacterial_spot.jpg'
        ]);

        Article::create([
            'article_title' => 'Pencegahan Early Blight pada Tomat',
            'article_content' => 'Early Blight disebabkan oleh jamur dan ditandai dengan bercak hitam pada daun. Pengendalian dapat dilakukan dengan mengendalikan gulma dan menjaga kelembapan tanah.',
            'article_url' => 'https://www.usda.gov/media/blog/2010/07/16/tomato-plant-diseases-and-how-stop-them',
            'disease_id' => 1,
            'image_cover' => 'path/to/image_early_blight.jpg'
        ]);

        Article::create([
            'article_title' => 'Menangani Late Blight pada Tanaman Tomat',
            'article_content' => 'Late Blight adalah penyakit serius yang menyebabkan bercak basah keabu-abuan di daun. Hindari kelembapan tinggi dan lakukan rotasi tanaman untuk pencegahan.',
            'article_url' => 'https://www.vegetables.cornell.edu/pest-management/disease-factsheets/managing-tomato-diseases-successfully/',
            'disease_id' => 2,
            'image_cover' => 'path/to/image_late_blight.jpg'
        ]);

        Article::create([
            'article_title' => 'Leaf Mold: Penyakit Jamur pada Tomat',
            'article_content' => 'Leaf Mold terjadi di lingkungan lembab dan menyebabkan daun bagian bawah ditutupi jamur hijau-zaitun. Menjaga sirkulasi udara adalah kunci untuk pencegahan.',
            'article_url' => 'https://hgic.clemson.edu/factsheet/tomato-diseases-disorders/',
            'disease_id' => 3,
            'image_cover' => 'path/to/image_leaf_mold.jpg'
        ]);

        Article::create([
            'article_title' => 'Mengatasi Septoria Leaf Spot pada Tomat',
            'article_content' => 'Septoria Leaf Spot menyebabkan bercak kecil berwarna abu-abu dengan tepi gelap. Pencegahannya meliputi menghindari kelembapan berlebih dan menjaga sirkulasi udara.',
            'article_url' => 'https://yardandgarden.extension.iastate.edu/how-to/managing-tomato-diseases-disorders-and-pests',
            'disease_id' => 4,
            'image_cover' => 'path/to/image_septoria_leaf_spot.jpg'
        ]);

        Article::create([
            'article_title' => 'Pengendalian Spider Mites pada Tanaman Tomat',
            'article_content' => "Spider Mites dapat menyebabkan daun kuning dan rontok. Mengendalikan populasi kutu laba-laba dengan pestisida yang tepat adalah langkah penting.",
            'article_url' => "https://www.vegetables.cornell.edu/pest-management/disease-factsheets/managing-tomato-diseases-successfully/",
            'disease_id' => 5,
            'image_cover' => "path/to/image_spider_mites.jpg"
        ]);

        Article::create([
            'article_title' => "Mengatasi Fusarium Wilt pada Tanaman Tomat",
            'article_content' => "Fusarium Wilt adalah penyakit yang disebabkan oleh jamur, mengakibatkan layu dan kematian tanaman. Gunakan varietas tahan dan lakukan rotasi tanaman.",
            'article_url' => "https://pmc.ncbi.nlm.nih.gov/articles/PMC5519495/",
            'disease_id' => 6,
            'image_cover' => "path/to/image_fusarium_wilt.jpg"
        ]);

        Article::create([
            'article_title' => "Penyakit Sclerotinia pada Tanaman Tomat",
            'article_content' => "Sclerotinia rot dapat menyebabkan kerusakan serius pada tanaman tomat. Praktik sanitasi yang baik dan pengendalian kelembapan sangat penting.",
            'article_url' => "https://www.usda.gov/media/blog/2010/07/16/tomato-plant-diseases-and-how-stop-them",
            'disease_id' => 7,
            'image_cover' => "path/to/image_sclerotinia.jpg"
        ]);

        Article::create([
            'article_title' => "Pencegahan Tomato Yellow Leaf Curl Virus",
            'article_content' => "Virus ini dapat menyebabkan kerugian besar dalam produksi tomat. Menggunakan varietas tahan dan mengelola hama vektor adalah kunci pencegahan.",
            'article_url' => "https://www.vegetables.cornell.edu/pest-management/disease-factsheets/managing-tomato-diseases-successfully/",
            'disease_id' => 8,
            'image_cover' => "path/to/image_yellow_leaf_curl.jpg"
        ]);

        Article::create([
            'article_title' => "Menangani Anthracnose pada Buah Tomat",
            'article_content' => "Anthracnose dapat menyebabkan bercak hitam pada buah tomat. Pastikan untuk memanen secara teratur dan menggunakan fungisida jika perlu.",
            'article_url' => "https://hgic.clemson.edu/factsheet/tomato-diseases-disorders/",
            'disease_id' => 9,
            'image_cover' => "path/to/image_anthracnose.jpg"
        ]);

        Article::create([
            'article_title' => 'Hepatitis: Kenali Gejalanya',
            'article_content' => 'Virus Hepatitis B dan C dapat menyebabkan kerusakan serius pada hati. Artikel ini menjelaskan gejala dan cara diagnosis.',
            'article_url' => 'https://www.prudential.co.id/id/pulse/article/penyakit-akibat-virus-lainnya/',
            'disease_id' => 3,
            'image_cover' => 'path/to/image3.jpg'
        ]);

        Article::create([
            'article_title' => 'Gejala dan Penanganan HIV/AIDS',
            'article_content' => 'HIV merusak sistem kekebalan tubuh. Artikel ini membahas gejala serta pentingnya deteksi dini.',
            'article_url' => 'https://www.prudential.co.id/id/pulse/article/penyakit-akibat-virus-lainnya/',
            'disease_id' => 4,
            'image_cover' => 'path/to/image4.jpg'
        ]);

        Article::create([
            'article_title' => 'Herpes Simplex: Apa yang Perlu Diketahui',
            'article_content' => 'Herpes simplex dapat menyebabkan luka pada area mulut atau alat kelamin. Pelajari lebih lanjut tentang penularan dan pengobatannya.',
            'article_url' => 'https://www.prudential.co.id/id/pulse/article/penyakit-akibat-virus-lainnya/',
            'disease_id' => 5,
            'image_cover' => 'path/to/image5.jpg'
        ]);

        Article::create([
            'article_title' => 'Penyakit Zika: Risiko dan Pencegahan',
            'article_content' => 'Zika adalah penyakit yang ditularkan oleh nyamuk dengan risiko terhadap ibu hamil. Artikel ini menjelaskan langkah pencegahan yang dapat diambil.',
            'article_url' => 'https://www.prudential.co.id/id/pulse/article/penyakit-akibat-virus-lainnya/',
            'disease_id' => 6,
            'image_cover' => 'path/to/image6.jpg'
        ]);
    }
}
