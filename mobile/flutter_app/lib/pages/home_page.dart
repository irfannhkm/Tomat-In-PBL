import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '30°C',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8EB69B)),
                    ),
                    Text(
                      'min 18C;max 31C',
                      style: TextStyle(fontSize: 8, color: Color(0xFF8EB69B)),
                    ),
                  ],
                ),
                const Spacer(),
                const ImageIcon(
                  AssetImage('assets/loc_icon.png'),
                  size: 10,
                  color: Color(0xFF8EB69B),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Kecamatan Tumpang',
                  style: TextStyle(fontSize: 14, color: Color(0xFF8EB69B)),
                ),
                const Spacer(),
                Image.asset(
                  'assets/sunny_cloud.png',
                  width: 50,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Bagian sapaan dan search bar
            const Row(
              children: [
                ImageIcon(
                  AssetImage('assets/person_circle.png'),
                  size: 50,
                  color: Color(0xFF8EB69B),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Afternoon,',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      'tomato lover!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search Your Plants',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
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
                  _buildGridItem(Icons.local_florist, 'Koleksi',
                      'Ketuk untuk melihat koleksi', const Color(0xFF8EB69B)),
                  _buildGridItem(
                      Icons.camera_alt_rounded,
                      'Identifikasi Penyakit',
                      'Ketuk untuk mengenali tanaman',
                      const Color(0xFF235347)),
                  _buildGridItem(Icons.person, 'Profile', 'Mengatur Profil',
                      const Color(0xFF163832)),
                  _buildGridItem(Icons.article, 'Artikel', 'Eksplorasi Artikel',
                      const Color(0xFF0B2B26)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.fit_screen_sharp,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[850],
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.green,
                size: 40,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.local_florist,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 40), // Spacing for FAB
            IconButton(
              icon: const Icon(
                Icons.article,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(
      IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}
