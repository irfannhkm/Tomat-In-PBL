import 'package:flutter/material.dart';

class DetailArticleScreen extends StatelessWidget {
  const DetailArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 265,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/detail_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(height: 60),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF449D87),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: const Text(
                                  'Tips Berguna',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Fall Garden Watering Technique',
                                style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 30,
                                    ),
                                  ],
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Card(
                          elevation: 5,
                          color: const Color(0xFF191d26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                  'Turpis dictum egestas dolor egestas. Netus pharetra, rhoncus '
                                  'tortor duis sit. In ipsum diam orci morbi ultricies massa amet.',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                  'Turpis dictum egestas dolor egestas. Netus pharetra, rhoncus '
                                  'tortor duis sit. In ipsum diam orci morbi ultricies massa amet.',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                  'Turpis dictum egestas dolor egestas. Netus pharetra, rhoncus '
                                  'tortor duis sit. In ipsum diam orci morbi ultricies massa amet.',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                  'Turpis dictum egestas dolor egestas. Netus pharetra, rhoncus '
                                  'tortor duis sit. In ipsum diam orci morbi ultricies massa amet.',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Sumber referensi: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle link tap
                                  },
                                  child: const Text(
                                    'Link Artikel',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
