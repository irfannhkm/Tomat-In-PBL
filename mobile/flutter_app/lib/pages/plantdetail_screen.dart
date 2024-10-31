import 'package:flutter/material.dart';

class PlantDetailScreen extends StatefulWidget {
  final String plantName;
  final String status;

  const PlantDetailScreen(
      {super.key, required this.plantName, required this.status});

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 27, 28),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 27, 28),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Detail Tanaman'),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          30), // Atur radius sesuai keinginan
                      child: Image.asset(
                        'assets/hand_touch_tomato.png', // Pastikan path sesuai dengan lokasi gambar Anda
                        fit: BoxFit
                            .cover, // Gambar menyesuaikan container dengan mengisi ruang
                        width: MediaQuery.of(context).size.width *
                            0.9, // Lebar gambar
                        height: MediaQuery.of(context).size.height *
                            0.4, // Tinggi gambar
                      ),
                    ),

                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/300', // Link gambar
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Nama tanaman
                    Text(
                      widget.plantName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Jenis tanaman
                    const Text(
                      'Vegetables',
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tanggal dan lokasi
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1 September 2024',
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    'Back Yard',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Pengingat perawatan
              _buildReminderBox(),

              const SizedBox(height: 20),

              // Kesehatan tanaman
              _buildHealthStatusBox(),

              const SizedBox(height: 20),

              // Saran perawatan
              const Text(
                'Saran perawatan',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildExpandableTile(
                'Penyiraman',
                'Intensitas penyiraman: Sedang',
                'Penyiraman yang cukup akan memastikan tanaman tetap tumbuh subur. Lakukan penyiraman secara berkala tergantung kondisi cuaca.',
              ),
              const SizedBox(height: 10),
              _buildExpandableTile(
                'Pencahayaan',
                'Intensitas cahaya: Matahari penuh',
                'Tomat membutuhkan pencahayaan penuh dari sinar matahari selama 6-8 jam per hari untuk fotosintesis yang optimal.',
              ),
              const SizedBox(height: 10),
              _buildExpandableTile(
                'Pemupukan',
                'Jenis pemupukan: Mingguan',
                'Pemupukan dilakukan setiap minggu menggunakan pupuk organik untuk menunjang pertumbuhan tanaman.',
              ),
              const SizedBox(height: 10),
              _buildDetailTile('Kelembapan', 'Batas kelembapan: -'),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat kotak pengingat perawatan
  Widget _buildReminderBox() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 89, 132, 119),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pengingat perawatan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildToggleSwitch('Penyiraman'),
          _buildToggleSwitch('Pencahayaan'),
          _buildToggleSwitch('Pemupukan'),
        ],
      ),
    );
  }

  // Fungsi untuk membuat kotak status kesehatan tanaman
  Widget _buildHealthStatusBox() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: widget.status.toLowerCase() == 'sehat'
            ? Colors.greenAccent
            : Colors.redAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Kesehatan Tanaman',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.status,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: widget.status.toLowerCase() == 'sehat'
                  ? const Color.fromARGB(255, 20, 120, 72)
                  : Colors.redAccent,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Lihat detail penyakit'),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat toggle switch
  Widget _buildToggleSwitch(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 16)),
        Switch(value: true, onChanged: (value) {}),
      ],
    );
  }

  // Fungsi untuk membuat expandable tile
  Widget _buildExpandableTile(String title, String subtitle, String content) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 89, 132, 119),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        iconColor: Colors.white,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(content, style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat detail tile (non-expandable)
  Widget _buildDetailTile(String title, String description) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 89, 132, 119),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        subtitle:
            Text(description, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
