import 'package:flutter/material.dart';
import 'package:flutter_app/pages/detail_article_screen.dart';
import 'package:flutter_app/pages/videoplayer_screen.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D26),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Berita dan Artikel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Chip(label: Text('Semua')),
                    SizedBox(width: 8),
                    Chip(label: Text('Trending')),
                    SizedBox(width: 8),
                    Chip(label: Text('Tips dan trik')),
                    SizedBox(width: 8),
                    Chip(label: Text('Panduan Perawatan')),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    const ArticleCard(
                      title: '5 cara mudah untuk merawat tanaman tomat',
                      category: 'Panduan Perawatan',
                      imagePath: 'assets/tomato_article.png', // Gambar tomat
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailArticleScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFDAF1DE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/watering_circle.png',
                                fit: BoxFit.cover),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tips dan trik',
                                    style: TextStyle(
                                      color: Color(0xFF2F776B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Teknik penyiraman "Fall garden"',
                                    style: TextStyle(
                                      color: Color(0xFF2F776B),
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const ArticleCard(
                      title:
                          'Tomat ungu baru yang dimodifikasi secara genetik mungkin akan beredar di pasar',
                      category: 'Trending',
                      imagePath: 'assets/image_trending.png',
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
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String category;
  final String imagePath;

  const ArticleCard({
    super.key,
    required this.title,
    required this.category,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const YoutubeVideoScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFDAF1DE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      color: Color(0xFF2F776B),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF2F776B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
