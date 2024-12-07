import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  final Function(int)
      onNavigate; // Callback function to navigate using MainScreen

  const HomePage({super.key, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).go('/weather');
                },
                child: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '30°C',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'min: 18°/max: 31°',
                          style:
                              TextStyle(fontSize: 11, color: Color(0xFF8EB69B)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const ImageIcon(
                      AssetImage('assets/loc_icon.png'),
                      size: 10,
                      color: Color(0xFF7AAB8D),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Malang',
                      style: TextStyle(fontSize: 14, color: Color(0xFFDAF1DD)),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/weather/2.png',
                      width: 70,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/person_circle.png'),
                    size: 50,
                    color: Color(0xFFC6D7D1),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Siang,',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD9DADA)),
                      ),
                      Text(
                        'Pecinta Tomat!',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFFD9DADA)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF8EB69B),
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF0B2B26)),
                  hintText: 'Cari Tomatmu',
                  hintStyle: const TextStyle(color: Color(0xFF153832)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Grid item
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildGridItem(
                      'pot',
                      'Koleksi',
                      'Menyimpan Koleksi Tomatmu',
                      const Color(0xFF163832),
                      1,
                    ),
                    _buildGridItem(
                      'camera_leaf',
                      'Deteksi',
                      'Mengidentifikasi Penyakit Daun Tomat',
                      const Color(0xFF235347),
                      0,
                    ),
                    _buildGridItem(
                      'user',
                      'Profile',
                      'Mengatur Profil',
                      const Color(0xFF235347),
                      3,
                    ),
                    _buildGridItem(
                      'article',
                      'Eksplorasi',
                      'Artikel dan Video',
                      const Color(0xFF163832),
                      2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
      String icon, String title, String subtitle, Color color, int pageIndex) {
    return GestureDetector(
      onTap: () {
        widget.onNavigate(
            pageIndex); // Use callback to change the selected index in MainScreen
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageIcon(
              AssetImage('assets/$icon.png'),
              size: 35,
              color: Color(0xFFC6D7D1),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
