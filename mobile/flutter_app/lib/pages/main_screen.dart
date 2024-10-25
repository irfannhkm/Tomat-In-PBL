import 'package:camera/camera.dart'; // Import untuk camera
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/article_screen.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/plantcollection_screen.dart';
import 'package:flutter_app/pages/profile_screen.dart';
import 'package:flutter_app/pages/scan_screen.dart'; // Import halaman ScanScreen

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const PlantCollectionScreen(),
    const ArticleScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk navigasi ke halaman ScanScreen
  void _navigateToScanScreen(BuildContext context) async {
    // Mengambil daftar kamera
    final cameras = await availableCameras();
    // Navigasi ke halaman ScanScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanScreen(cameras: cameras),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToScanScreen(context), // Navigasi ke halaman ScanScreen
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(
          Icons.camera_alt, // Ubah ikon FAB ke kamera
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
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.green : Colors.white,
                size: 40,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.local_florist,
                color: _selectedIndex == 1 ? Colors.green : Colors.white,
                size: 35,
              ),
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 40), // Spacing untuk FAB
            IconButton(
              icon: Icon(
                Icons.article,
                color: _selectedIndex == 2 ? Colors.green : Colors.white,
                size: 35,
              ),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 3 ? Colors.green : Colors.white,
                size: 35,
              ),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
