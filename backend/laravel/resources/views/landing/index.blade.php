<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Tomat-In | Landing Page</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="images/favicon.png" rel="icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Nunito:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="vendor/aos/aos.css" rel="stylesheet">
  <link href="vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Main CSS File -->
  <link href="css/landing/main.css" rel="stylesheet">
</head>

<body class="index-page">

  <header id="header" class="header d-flex align-items-center fixed-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center">

      <a href="/" class="logo d-flex align-items-center me-auto">
        <img src="img/logo_tomatin_upscayl.png" alt="">
      </a>

      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="#hero" class="">Beranda</a></li>
          <li><a href="#about">Tentang Kami</a></li>
          <li><a href="#features">Fitur Utama</a></li>
          <li><a href="#services">Arsitektur Aplikasi</a></li>
          <li><a href="#team">Tim</a></li>
          <li><a href="#contact">Kontak</a></li>
        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>

      <a class="btn-getstarted" href="{{ route('filament.admin.auth.login') }}">Masuk</a>
    </div>
  </header>

  <main class="main">

    <!-- Hero Section -->
    <section id="hero" class="hero section">
      <div class="hero-bg">
        <img src="img/hero-bg-light.webp" alt="">
      </div>
      <div class="container text-center">
        <div class="d-flex flex-column justify-content-center align-items-center">
          <h1 data-aos="fade-up" class="">Selamat datang di <span>Tomatin</span></h1>
          <p data-aos="fade-up" data-aos-delay="100" class="">Tumbuh lebih jauh dan berkembang lebih cerdas<br></p>
          <div class="d-flex" data-aos="fade-up" data-aos-delay="200">
            <a href="#about" class="btn-get-started">Mulai</a>
            <a href="https://youtu.be/FSFBPtRO4HU?si=IGMQ7oExQyZ4xw58" class="glightbox btn-watch-video d-flex align-items-center"><i class="bi bi-play-circle"></i><span>Lihat Video</span></a>
          </div>
          <img src="img/perawatan.png" class="img-fluid hero-img" alt="" data-aos="zoom-out" data-aos-delay="300">
        </div>
      </div>

    </section><!-- /Hero Section -->

    <!-- Featured Services Section -->
    <section id="featured-services" class="featured-services section">

      <div class="container">

        <div class="row gy-4">

          <div class="col-xl-4 col-lg-6" data-aos="fade-up" data-aos-delay="100">
            <div class="service-item d-flex">
              <div class="icon flex-shrink-0"><i class="bi bi-upc-scan"></i></div>
              <div>
                <h4 class="title"><a href="#" class="stretched-link">Deteksi Penyakit</a></h4>
                <p class="description">Menggunakan kamera ponsel untuk menganalisis daun tomat dan mendeteksi gejala penyakit.</p>
              </div>
            </div>
          </div>
          <!-- End Service Item -->

          <div class="col-xl-4 col-lg-6" data-aos="fade-up" data-aos-delay="200">
            <div class="service-item d-flex">
              <div class="icon flex-shrink-0"><i class="bi bi-card-checklist"></i></div>
              <div>
                <h4 class="title"><a href="#" class="stretched-link">Monitoring Perawatan</a></h4>
                <p class="description">Memantau berbagai aspek pertumbuhan tanaman, seperti kelembapan tanah, pencahayaan, dan suhu.</p>
              </div>
            </div>
          </div><!-- End Service Item -->

          <div class="col-xl-4 col-lg-6" data-aos="fade-up" data-aos-delay="300">
            <div class="service-item d-flex">
              <div class="icon flex-shrink-0"><i class="bi bi-person-hearts"></i></div>
              <div>
                <h4 class="title"><a href="#" class="stretched-link">User Friendly</a></h4>
                <p class="description">Mudah digunakan untuk berbagai kalangan baik petani ataupun rumah tangga</p>
              </div>
            </div>
          </div><!-- End Service Item -->

        </div>

      </div>

    </section><!-- /Featured Services Section -->

    <!-- About Section -->
    <!-- About Section -->
<section id="about" class="about section">
  <div class="container">
    <div class="row gy-4">

      <!-- About Content -->
      <div class="col-lg-6 content" data-aos="fade-up" data-aos-delay="100">
        <p class="who-we-are">Tentang Kami</p>
        <h3>Meningkatkan Produktivitas dengan Teknologi Cerdas</h3>
        <p class="fst-italic">
          TomatIn adalah aplikasi mobile yang membantu petani dan rumah tangga dalam mengelola tanaman tomat. Aplikasi ini memanfaatkan teknologi pengolahan citra dan machine learning untuk mendeteksi penyakit pada daun tomat.
        </p>
        <ul>
          <li><i class="bi bi-check-circle"></i> <span><strong>Petani:</strong> Memudahkan pengelolaan tanaman tomat dalam skala besar dengan fitur deteksi penyakit yang cepat dan akurat.</span></li>
          <li><i class="bi bi-check-circle"></i> <span><strong>Rumah Tangga:</strong> Cocok untuk keluarga yang menanam tomat di pekarangan atau pot, membantu dalam perawatan sehari-hari dengan fitur monitoring sederhana dan notifikasi perawatan.</span></li>
        </ul>
        <a href="#" class="read-more"><span>Pelajari Lebih Lanjut</span><i class="bi bi-arrow-right"></i></a>
      </div>

      <!-- About Images -->
      <div class="col-lg-6 about-images" data-aos="fade-up" data-aos-delay="200">
        <div class="row gy-4">
          <div class="col-lg-6">
            <img src="img/12.png" class="img-fluid" alt="Petani Tomat">
          </div>
          <div class="col-lg-6">
            <div class="row gy-4">
              <div class="col-lg-12">
                <img src="img/11.png" class="img-fluid" alt="Monitoring Tanaman">
              </div>
              <div class="col-lg-12">
                <img src="img/tomatpot.jpg" class="img-fluid" alt="Perawatan Tomat">
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
  </section>
  <!-- More Features Section -->
<section id="more-features" class="more-features section">
  <div class="container">

    <div class="row justify-content-around gy-4">

      <!-- Content Section -->
      <div class="col-lg-6 d-flex flex-column justify-content-center order-2 order-lg-1" data-aos="fade-up" data-aos-delay="100">
        <h3>Pentingnya Deteksi Penyakit pada Daun Tomat</h3>
        <p>Indonesia merupakan salah satu produsen tomat terbesar di Asia Tenggara. Berikut beberapa fakta dan tantangan terkait budidaya tomat:</p>

        <div class="row">

          <div class="col-lg-6 icon-box d-flex">
            <i class="bi bi-bar-chart-fill flex-shrink-0"></i>
            <div>
              <h4>Produksi Nasional</h4>
              <p>Produksi tomat Indonesia mencapai 1,12 juta ton pada tahun 2022, dengan Jawa Barat, Jawa Timur, dan Sumatera Utara sebagai kontributor utama.</p>
            </div>
          </div><!-- End Icon Box -->

          <div class="col-lg-6 icon-box d-flex">
            <i class="bi bi-patch-exclamation-fill flex-shrink-0"></i>
            <div>
              <h4>Tantangan Penyakit</h4>
              <p>Penyakit pada daun tomat sering kali tidak terdeteksi dini, menyebabkan kerugian besar pada hasil panen petani.</p>
            </div>
          </div><!-- End Icon Box -->

          <div class="col-lg-6 icon-box d-flex">
            <i class="bi bi-people-fill flex-shrink-0"></i>
            <div>
              <h4>Dukungan untuk Petani</h4>
              <p>Aplikasi seperti TomatIn dapat membantu petani mendeteksi penyakit lebih awal dan memberikan panduan perawatan yang efisien.</p>
            </div>
          </div><!-- End Icon Box -->

          <div class="col-lg-6 icon-box d-flex">
            <i class="bi bi-house-fill flex-shrink-0"></i>
            <div>
              <h4>Keluarga di Rumah</h4>
              <p>Tomat juga ditanam dalam skala kecil di pekarangan rumah, memerlukan monitoring sederhana untuk menjaga kualitas tanaman.</p>
            </div>
          </div><!-- End Icon Box -->

        </div>
      </div>

      <!-- Image Section -->
      <div class="features-image col-lg-5 order-1 order-lg-2" data-aos="fade-up" data-aos-delay="200">
        <img src="img/tomato1.png" alt="Tomato Farm" class="img-fluid">
      </div>

    </div>

  </div>
</section>


    <!-- Clients Section -->
    <section id="clients" class="clients section">

      <div class="container" data-aos="fade-up">

        <div class="row gy-4 justify-content-center">

          <div class="col-xl-2 col-md-3 col-6 client-logo">
            <img src="img/clients/logo_polinema.png" class="img-fluid" alt="">
          </div><!-- End Client Item -->

          <div class="col-xl-2 col-md-3 col-6 client-logo">
            <img src="img/clients/jti_polinema.png" class="img-fluid" alt="">
          </div><!-- End Client Item -->

          <div class="col-xl-2 col-md-3 col-6 client-logo">
            <img src="img/clients/joss.jpg" class="img-fluid" alt="">
          </div><!-- End Client Item -->

          <div class="col-xl-2 col-md-3 col-6 client-logo">
            <img src="img/clients/rek.jpg" class="img-fluid" alt="">
          </div><!-- End Client Item -->

        </div>

      </div>

    </section><!-- /Clients Section -->

    <!-- Features Section -->
<section id="features" class="features section">

  <!-- Section Title -->
  <div class="container section-title" data-aos="fade-up">
    <h2 class="">Fitur Utama</h2>
    <p>Aplikasi TomatIn menawarkan solusi cerdas untuk mendukung perawatan tanaman tomat Anda.</p>
  </div><!-- End Section Title -->

  <div class="container">
    <div class="row justify-content-between">

      <!-- Features List -->
      <div class="col-lg-5 d-flex align-items-center">
        <ul class="nav nav-tabs" data-aos="fade-up" data-aos-delay="100">
          <li class="nav-item">
            <a class="nav-link active show" data-bs-toggle="tab" data-bs-target="#features-tab-1">
              <i class="bi bi-search"></i>
              <div>
                <h4 class="d-none d-lg-block">Identifikasi Penyakit Daun Tomat</h4>
                <p>
                  Unggah gambar daun tomat Anda dan dapatkan diagnosis instan berdasarkan teknologi machine learning.
                </p>
              </div>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" data-bs-target="#features-tab-2">
              <i class="bi bi-graph-up"></i>
              <div>
                <h4 class="d-none d-lg-block">Monitoring Tanaman</h4>
                <p>
                  Pantau kondisi tanaman Anda, termasuk informasi cuaca, kelembapan, dan jadwal perawatan.
                </p>
              </div>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-bs-toggle="tab" data-bs-target="#features-tab-3">
              <i class="bi bi-book"></i>
              <div>
                <h4 class="d-none d-lg-block">Artikel & Edukasi</h4>
                <p>
                  Akses artikel dan panduan lengkap untuk menjaga kesehatan tanaman tomat Anda.
                </p>
              </div>
            </a>
          </li>
        </ul><!-- End Tab Nav -->

      </div>

      <!-- Features Tab Content -->
      <div class="col-lg-6">

        <div class="tab-content" data-aos="fade-up" data-aos-delay="200">

          <div class="tab-pane fade active show" id="features-tab-1">
            <img src="img/deteksi.png" alt="Identifikasi Penyakit" class="img-fluid">
          </div><!-- End Tab Content Item -->

          <div class="tab-pane fade" id="features-tab-2">
            <img src="img/monitoring.png" alt="Monitoring Tanaman" class="img-fluid">
          </div><!-- End Tab Content Item -->

          <div class="tab-pane fade" id="features-tab-3">
            <img src="img/blog.png" alt="Artikel Edukasi" class="img-fluid">
          </div><!-- End Tab Content Item -->
        </div>

      </div>

    </div>

  </div>

</section><!-- /Features Section -->

<!-- Features Details Section -->
<section id="features-details" class="features-details section">

  <div class="container">

    <!-- Feature Detail Item 1 -->
    <div class="row gy-4 justify-content-between features-item">
      <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
        <img src="img/man farmer.png" class="img-fluid" alt="Identifikasi Penyakit">
      </div>
      <div class="col-lg-5 d-flex align-items-center" data-aos="fade-up" data-aos-delay="200">
        <div class="content">
          <h3>Deteksi Penyakit yang Akurat</h3>
          <p>
            Dengan algoritma machine learning, aplikasi ini dapat mendeteksi berbagai penyakit daun tomat secara akurat dan cepat.
          </p>
          <a href="#" class="btn more-btn">Pelajari Lebih Lanjut</a>
        </div>
      </div>
    </div><!-- Features Item -->

    <!-- Feature Detail Item 2 -->
    <div class="row gy-4 justify-content-between features-item">
      <div class="col-lg-5 d-flex align-items-center order-2 order-lg-1" data-aos="fade-up" data-aos-delay="100">
        <div class="content">
          <h3>Rekomendasi Perawatan</h3>
          <p>
            Dapatkan rekomendasi perawatan harian berdasarkan data cuaca dan kondisi tanaman Anda.
          </p>
          <ul>
            <li><i class="bi bi-droplet"></i> Penyiraman yang Tepat</li>
            <li><i class="bi bi-brightness-high"></i> Kebutuhan Cahaya Matahari</li>
            <li><i class="bi bi-bug"></i> Pengendalian Hama</li>
          </ul>
          <a href="#" class="btn more-btn">Pelajari Lebih Lanjut</a>
        </div>
      </div>
      <div class="col-lg-6 order-1 order-lg-2" data-aos="fade-up" data-aos-delay="200">
        <img src="img/reminder.png" class="img-fluid" alt="Rekomendasi Perawatan">
      </div>
    </div><!-- Features Item -->

  </div>

</section><!-- /Features Details Section -->

  <!-- Services Section -->
<section id="services" class="services section">
  <!-- Section Title -->
  <div class="container section-title" data-aos="fade-up">
    <h2>Arsitektur Aplikasi</h2>
    <p>Aplikasi TomatIn dirancang menggunakan teknologi modern untuk mendukung deteksi penyakit daun tomat dan monitoring tanaman secara efisien.</p>
  </div>

  <div class="container">
    <div class="row g-5">

      <!-- Laravel Filament -->
      <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
        <div class="service-item item-cyan position-relative">
          <i class="bi bi-code-slash icon"></i>
          <div>
            <h3>Laravel Filament</h3>
            <p>Framework Laravel Filament digunakan untuk membangun backend dan dashboard admin yang powerful dan user-friendly.</p>
            <a href="https://laravel.com/" class="read-more stretched-link" target="_blank">Pelajari Lebih Lanjut <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
      </div>

      <!-- Flutter -->
      <div class="col-lg-6" data-aos="fade-up" data-aos-delay="200">
        <div class="service-item item-orange position-relative">
          <i class="bi bi-phone icon"></i>
          <div>
            <h3>Flutter</h3>
            <p>Aplikasi mobile dibangun menggunakan Flutter, memungkinkan pengalaman pengguna yang mulus di berbagai platform seperti Android dan iOS.</p>
            <a href="https://flutter.dev/" class="read-more stretched-link" target="_blank">Pelajari Lebih Lanjut <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
      </div>

      <!-- FastAPI -->
      <div class="col-lg-6" data-aos="fade-up" data-aos-delay="300">
        <div class="service-item item-teal position-relative">
          <i class="bi bi-cloud-arrow-up icon"></i>
          <div>
            <h3>FastAPI</h3>
            <p>FastAPI digunakan untuk pengolahan gambar secara real-time menggunakan machine learning, mendukung kecepatan deteksi penyakit daun.</p>
            <a href="https://fastapi.tiangolo.com/" class="read-more stretched-link" target="_blank">Pelajari Lebih Lanjut <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
      </div>

      <!-- Google Auth -->
      <div class="col-lg-6" data-aos="fade-up" data-aos-delay="400">
        <div class="service-item item-red position-relative">
          <i class="bi bi-google icon"></i>
          <div>
            <h3>Google Authentication</h3>
            <p>Sistem login menggunakan Google OAuth memastikan keamanan data pengguna dan kemudahan dalam autentikasi.</p>
            <a href="https://developers.google.com/identity" class="read-more stretched-link" target="_blank">Pelajari Lebih Lanjut <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
      </div>

      <!-- OpenWeather API -->
      <div class="col-lg-6" data-aos="fade-up" data-aos-delay="500">
        <div class="service-item item-indigo position-relative">
          <i class="bi bi-cloud-sun icon"></i>
          <div>
            <h3>OpenWeather API</h3>
            <p>Integrasi OpenWeather API memberikan informasi cuaca untuk membantu pengguna dalam merawat tanaman berdasarkan kondisi lingkungan.</p>
            <a href="https://openweathermap.org/api" class="read-more stretched-link" target="_blank">Pelajari Lebih Lanjut <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
      </div>

      <!-- YOLOv11 dan Dataset -->
      <div class="col-lg-6" data-aos="fade-up" data-aos-delay="600">
        <div class="service-item item-pink position-relative">
          <i class="bi bi-cpu icon"></i>
          <div>
            <h3>YOLOv11 & Dataset Kaggle</h3>
            <p>Model YOLOv11 digunakan untuk deteksi penyakit daun dengan dataset dari Kaggle yang berisi ribuan gambar daun tomat yang memiliki penyakit.</p>
            <a href="https://www.kaggle.com/datasets/kaustubhb999/tomatoleaf" class="read-more stretched-link" target="_blank">Pelajari Lebih Lanjut <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
      </div>

    </div>
  </div>
</section>
<!-- End Services Section -->
    <!-- Faq Section -->
<section id="faq" class="faq section">
  <!-- Section Title -->
  <div class="container section-title" data-aos="fade-up">
    <img src="img/hero-services-img.webp" alt="" class="img-fluid">
    <h2>Pertanyaan yang Sering Diajukan</h2>
  </div><!-- End Section Title -->

  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-10" data-aos="fade-up" data-aos-delay="100">
        <div class="faq-container">

          <!-- Faq item -->
          <div class="faq-item faq-active">
            <h3>Bagaimana cara kerja aplikasi TomatIn?</h3>
            <div class="faq-content">
              <p>Aplikasi TomatIn menggunakan teknologi pengolahan citra dan machine learning untuk mendeteksi penyakit pada daun tomat melalui gambar yang Anda unggah. Hasilnya akan memberikan diagnosis dan saran perawatan yang sesuai.</p>
            </div>
            <i class="faq-toggle bi bi-chevron-right"></i>
          </div><!-- End Faq item -->

          <div class="faq-item">
            <h3>Apakah aplikasi ini hanya untuk petani skala besar?</h3>
            <div class="faq-content">
              <p>Tidak, aplikasi ini dirancang untuk digunakan oleh siapa saja, termasuk rumah tangga yang menanam tomat di pot atau pekarangan kecil. Fitur monitoring membantu dalam merawat tanaman tomat dengan lebih efektif.</p>
            </div>
            <i class="faq-toggle bi bi-chevron-right"></i>
          </div><!-- End Faq item -->

          <div class="faq-item">
            <h3>Data apa saja yang diperlukan untuk monitoring tanaman?</h3>
            <div class="faq-content">
              <p>Anda hanya perlu menginput lokasi tanaman, jenis media tanam (pot, lahan, pekarangan), dan frekuensi perawatan seperti penyiraman atau pemupukan. Aplikasi akan memberikan rekomendasi berdasarkan kondisi cuaca setempat.</p>
            </div>
            <i class="faq-toggle bi bi-chevron-right"></i>
          </div><!-- End Faq item -->

          <div class="faq-item">
            <h3>Apakah aplikasi ini membutuhkan koneksi internet?</h3>
            <div class="faq-content">
              <p>Ya, koneksi internet diperlukan untuk mengunggah gambar daun, menerima hasil diagnosis, dan mengakses data cuaca melalui API OpenWeather.</p>
            </div>
            <i class="faq-toggle bi bi-chevron-right"></i>
          </div><!-- End Faq item -->

          <div class="faq-item">
            <h3>Bagaimana cara menjaga privasi data pengguna?</h3>
            <div class="faq-content">
              <p>Data pengguna, termasuk gambar yang diunggah, dilindungi dengan enkripsi dan hanya digunakan untuk analisis penyakit. Kami menggunakan standar keamanan tinggi untuk menjaga privasi data Anda.</p>
            </div>
            <i class="faq-toggle bi bi-chevron-right"></i>
          </div><!-- End Faq item -->

          <div class="faq-item">
            <h3>Apakah aplikasi ini memberikan solusi perawatan tanaman?</h3>
            <div class="faq-content">
              <p>Ya, setelah diagnosis, aplikasi ini memberikan saran perawatan yang meliputi penyiraman, pemupukan, dan pengendalian hama berdasarkan jenis penyakit yang terdeteksi.</p>
            </div>
            <i class="faq-toggle bi bi-chevron-right"></i>
          </div><!-- End Faq item -->

        </div>
      </div><!-- End Faq Column -->
    </div>
  </div>
</section><!-- /Faq Section -->

<section id="team" class="team">

  <div class="container section-title" data-aos="fade-up">
      <header class="section-header">
          <h2>Anggota Tim Kami</h2>
      </header>

      <!-- Single card on top -->
      <div class="row justify-content-center mb-4">
          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
              <div class="member">
                  <div class="member-img">
                      <img src="img/team/irfan(1,1).jpg" class="img-fluid" alt="">
                      <div class="social">
                        <a href="https://github.com/irfannhkm"><i class="bi bi-github"></i></a>
                        <a href="https://www.facebook.com/profile.php?id=100023448218858&mibextid=JRoKGi"><i class="bi bi-facebook"></i></a>
                        <a href="https://www.instagram.com/irfan.nhkm/"><i class="bi bi-instagram"></i></a>
                        <a href="https://www.linkedin.com/in/muhammad-irfan-nur-hakim-0550292b4?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app"><i class="bi bi-linkedin"></i></a>
                    </div>
                  </div>
                  <div class="member-info">
                      <h4>Muhammad Irfan Nur Hakim</h4>
                      <p>2241720230 | 15
                      </p>
                      <span>PM | Backend Developer</span>
                  </div>
              </div>
          </div>
      </div>

      <!-- Four cards below -->
      <div class="row gy-4">
          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="200">
              <div class="member">
                  <div class="member-img">
                      <img src="img/team/alhamdana.jpg" class="img-fluid" alt="">
                      <div class="social">
                          <a href="https://github.com/Alhamdanaaa"><i class="bi bi-github"></i></a>
                          <a href="https://www.facebook.com/alhamdana.fariz"><i class="bi bi-facebook"></i></a>
                          <a href="https://www.instagram.com/alhamdanaaa/"><i class="bi bi-instagram"></i></a>
                          <a href="https://www.linkedin.com/in/alhamdana-fariz-al-furqaan-663b92315"><i class="bi bi-linkedin"></i></a>
                      </div>
                  </div>
                  <div class="member-info">
                      <h4>Alhamdana Fariz Al Furqaan</h4>
                      <p>2241720115 | 03
                      </p>
                      <span>Machine Learning</span>
                  </div>
              </div>
          </div>

          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="300">
              <div class="member">
                  <div class="member-img">
                      <img src="img/team/ana.png" class="img-fluid" alt="">
                      <div class="social">
                          <a href="https://github.com/"><i class="bi bi-github"></i></a>
                          <a href="https://www.facebook.com/"><i class="bi bi-facebook"></i></a>
                          <a href="https://www.instagram.com/"><i class="bi bi-instagram"></i></a>
                          <a href="https://www.linkedin.com/in/"><i class="bi bi-linkedin"></i></a>
                      </div>
                  </div>
                  <div class="member-info">
                      <h4>Ana Bellatus Mustaqfiro </h4>
                      <p>2241720095 | 04
                      </p>
                      <span>Mobile Developer</span>
                  </div>
              </div>
          </div>

          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="400">
              <div class="member">
                  <div class="member-img">
                      <img src="img/team/mahi.jpg" class="img-fluid" alt="">
                      <div class="social">
                          <a href="https://github.com/nizarmahi"><i class="bi bi-github"></i></a>
                          <a href="#"><i class="bi bi-facebook"></i></a>
                          <a href="https://www.instagram.com/mahinizar/"><i class="bi bi-instagram"></i></a>
                          <a href="#"><i class="bi bi-linkedin"></i></a>
                      </div>
                  </div>
                  <div class="member-info">
                      <h4>Mochammad Nizar Mahi </h4>
                      <p>2241720185 | 13
                      </p>
                      <span>Keamanan Jaringan</span>
                  </div>
              </div>
          </div>

          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="500">
              <div class="member">
                  <div class="member-img">
                      <img src="img\team\kaka.jpg" class="img-fluid" alt="">
                      <div class="social">
                        <a href="https://github.com/Zakaal"><i class="bi bi-github"></i></a>
                        <a href="https://www.facebook.com/profile.php?id=100017615168635"><i class="bi bi-facebook"></i></a>
                        <a href="https://www.instagram.com/zakaalfaj/"><i class="bi bi-instagram"></i></a>
                        <a href="https://www.linkedin.com/in"><i class="bi bi-linkedin"></i></a>
                      </div>
                  </div>
                  <div class="member-info">
                      <h4>Mochammad Zakaro Al Fajri</h4>
                      <p>2241720175 | 14
                      </p>
                      <span>UI/UX Figma</span>
                  </div>
              </div>
          </div>
      </div>

  </div>

</section><!-- End Team Section -->
    <!-- Contact Section -->
    <section id="contact" class="contact section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Hubungi Kami</h2>
        <p>Berikan komentar dan saran Anda</p>
      </div><!-- End Section Title -->

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row gy-4">

          <div class="col-lg-6">
            <div class="info-item d-flex flex-column justify-content-center align-items-center" data-aos="fade-up" data-aos-delay="200">
              <i class="bi bi-geo-alt"></i>
              <h3>Alamat</h3>
              <p>Jl. Soekarno Hatta No.9, Mojolangu, Kec. Lowokwaru, Kota Malang, Jawa Timur 65141</p>
            </div>
          </div><!-- End Info Item -->

          <div class="col-lg-3 col-md-6">
            <div class="info-item d-flex flex-column justify-content-center align-items-center" data-aos="fade-up" data-aos-delay="300">
              <i class="bi bi-telephone"></i>
              <h3>Hubungi Kami</h3>
              <p>+62 877 7046 7527</p>
            </div>
          </div><!-- End Info Item -->

          <div class="col-lg-3 col-md-6">
            <div class="info-item d-flex flex-column justify-content-center align-items-center" data-aos="fade-up" data-aos-delay="400">
              <i class="bi bi-envelope"></i>
              <h3>Email Kami</h3>
              <p>leafingrowbeyond@gmail.com</p>
            </div>
          </div><!-- End Info Item -->

        </div>

        <div class="row gy-4 mt-1">
          <div class="col-lg-6" data-aos="fade-up" data-aos-delay="300">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3951.5304466406187!2d112.61196947505385!3d-7.944006892080186!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd629dfd58aaf95%3A0xe72a182dfd18e01c!2sGedung%20Teknik%20Sipil%2C%20Teknik%20Informatika%20%26%20Magister%20Terapan%2C%20POLITEKNIK%20NEGERI%20MALANG!5e0!3m2!1sid!2sid!4v1732465494258!5m2!1sid!2sid" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
          </div><!-- End Google Maps -->

          <div class="col-lg-6">
            <form action="{{ route('contact.send') }}" method="POST" class="php-email-form" data-aos="fade-up" data-aos-delay="400">
                @csrf
                <div class="row gy-4">

                    <div class="col-md-6">
                        <input type="text" name="name" class="form-control" placeholder="Your Name" value="{{ old('name') }}" required>
                        @error('name')
                            <small style="color: red;">{{ $message }}</small>
                        @enderror
                    </div>

                    <div class="col-md-6">
                        <input type="email" class="form-control" name="email" placeholder="Your Email" value="{{ old('email') }}" required>
                        @error('email')
                            <small style="color: red;">{{ $message }}</small>
                        @enderror
                    </div>

                    <div class="col-md-12">
                        <input type="text" class="form-control" name="subject" placeholder="Subject" value="{{ old('subject') }}" required>
                        @error('subject')
                            <small style="color: red;">{{ $message }}</small>
                        @enderror
                    </div>

                    <div class="col-md-12">
                        <textarea class="form-control" name="message" rows="6" placeholder="Message" required>{{ old('message') }}</textarea>
                        @error('message')
                            <small style="color: red;">{{ $message }}</small>
                        @enderror
                    </div>

                    <div class="col-md-12 text-center">
                        @if(session('success'))
                            <div class="sent-message" style="color: green;">{{ session('success') }}</div>
                        @endif
                        @if(session('error'))
                            <div class="error-message" style="color: red;">{{ session('error') }}</div>
                        @endif
                        <button type="submit" name="submit">Send Message</button>
                    </div>

                </div>
            </form>
        </div>


        </div>

      </div>

    </section><!-- /Contact Section -->

  </main>

  <footer id="footer" class="footer position-relative">
    <div class="container footer-top">
      <div class="row gy-4">
        <div class="col-lg-8 col-md-6 footer-about">
          <a href="" class="logo d-flex align-items-center">
            <img src="img/logo_tomatin_upscayl.png" alt="">
          </a>
          <div class="footer-contact pt-3">
            <p>Jl. Soekarno Hatta No.9, Mojolangu, Kec. Lowokwaru, Kota Malang</p>
            <p>Jawa Timur, 65141</p>
            <p class="mt-3"><strong>Phone:</strong> <span>+62 877 7046 7527</span></p>
            <p><strong>Email:</strong> <span>leafingrowbeyond@gmail.com</span></p>
          </div>
          <div class="social-links d-flex mt-4">
            <a href=""><i class="bi bi-twitter"></i></a>
            <a href=""><i class="bi bi-facebook"></i></a>
            <a href=""><i class="bi bi-instagram"></i></a>
            <a href=""><i class="bi bi-linkedin"></i></a>
            <a href=""><i class="bi bi-github"></i></a>
          </div>
        </div>
        <div class="col-lg-4 col-md-6 justify-content-end">
          <img src="img/tomat animasi.png" alt="" class="img-fluid" data-aos-delay="100">
        </div>
      </div>
    </div>

    <div class="container copyright text-center mt-4">
      <p>© <span>Copyright</span> <strong class="px-1 sitename">TomatIn.</strong><span>All Rights Reserved</span></p>
      <div class="credits">

        Designed by <a href="https://github.com/irfannhkm/tomat-in-pbl">Kelompok 4 | TI-3F</a>
      </div>
    </div>

  </footer>

  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="vendor/php-email-form/validate.js"></script>
  <script src="vendor/aos/aos.js"></script>
  <script src="vendor/glightbox/js/glightbox.min.js"></script>
  <script src="vendor/swiper/swiper-bundle.min.js"></script>

  <!-- Main JS File -->
  <script src="js/main.js"></script>

</body>

</html>
