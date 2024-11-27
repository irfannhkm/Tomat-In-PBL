# Tomat-In 
`Grow beyond`

**Tomat-In** adalah aplikasi berbasis web dan mobile untuk identifikasi penyakit dan monitoring kondisi daun tomat secara otomatis, untuk meningkatkan efisiensi pertanian baik di tingkat petani maupun rumah tangga. Proyek ini menggunakan teknologi **Laravel** (PHP) dan **FastAPI** (Python) sebagai backend, serta **Flutter** untuk frontend mobile. 

## 📧 Anggota Tim
* Alhamdana Fariz Al Furqaan  | (Machine Learning)
* Ana Bellatus Mustaqfiro     | (Mobile Developer)
* Mochammad Nizar Mahi        | (Keamanan Jaringan)
* Mochammad Zakaro Al Fajri   | (UI/UX Figma)
* Muhammad Irfan Nur Hakim    | (Backend Developer)

## 🚀 Fitur Utama
- **Identifikasi Penyakit Daun Tomat** menggunakan teknik machine learning dan computer vision.
- **Monitoring Kondisi Daun** dengan analisis citra dan pemantauan data secara real-time.
- **Aplikasi Mobile dan Web** untuk memudahkan pengguna dalam memantau kondisi tanaman kapan saja dan di mana saja.

## 📂 Struktur Folder
Berikut adalah struktur folder dalam proyek ini:
```
tomat-in/
├── backend/
│   ├── laravel/
│   └── fastapi/
├── mobile/
│   └── flutter_app/
└── README.md
```

## 🛠️ Teknologi yang Digunakan
- **Backend Web/API**: [Laravel](https://laravel.com/) (PHP), [Filament Admin](https://filamentphp.com/)
- **Backend Python**: [FastAPI](https://fastapi.tiangolo.com/) untuk pengolahan citra dan integrasi machine learning
- **Frontend Mobile**: [Flutter](https://flutter.dev/) untuk aplikasi mobile multiplatform
- **Database**: PostgreSQL
- **Computer Vision & Machine Learning**: Python (OpenCV, TensorFlow, dan scikit-learn)

## 📦 Instalasi dan Pengaturan

### 1. Clone Repositori
Clone repositori ini ke komputer lokal Anda:
```bash
git clone https://github.com/irfannhkm/tomat-in-pbl.git
cd tomat-in
```
### 2. Backend Laravel Setup
Masuk ke folder backend Laravel:
```bash
cd backend/laravel
```

Install dependencies Laravel menggunakan Composer:
```bash
composer install
```
Salin file .env dan konfigurasi environment Anda:
```bash
cp .env.example .env
php artisan key:generate
```
Jalankan migrasi database:
```bash
php artisan migrate
```
Jalankan server Laravel:
```bash
php artisan serve
```
### 3. Backend FastAPI Setup
Masuk ke folder backend FastAPI:
```bash
cd backend/fastapi
```
Buat virtual environment dan aktifkan:
```bash
python3 -m venv venv
source venv/bin/activate   # Linux/Mac
venv\Scripts\activate      # Windows
```
Install dependencies FastAPI:
```bash
pip install -r requirements.txt
Jalankan FastAPI server:
```
```bash
uvicorn main:app --reload
```
### 4. Mobile Frontend Flutter Setup
Masuk ke folder aplikasi Flutter:
```bash
cd mobile/flutter-app/flutter_app
```
Jalankan aplikasi Flutter:
```bash
flutter pub get
flutter run
```
## 🧑‍💻 Kontribusi
Kami sangat menghargai kontribusi dari semua pihak. Untuk berkontribusi:

1. Fork repositori ini.
2. Buat branch baru untuk fitur atau perbaikan (git checkout -b feature-branch).
3. Commit perubahan Anda (git commit -m "Menambahkan fitur X").
4. Push ke branch (git push origin feature-branch).
5. Buat Pull Request (PR) dan jelaskan perubahan yang Anda lakukan.
   
## 📝 Lisensi
Proyek ini menggunakan lisensi MIT. Lihat file LICENSE untuk informasi lebih lanjut.

---




