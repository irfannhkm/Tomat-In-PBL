import 'package:flutter/material.dart';
import 'package:tomatin/data/repository/article_repository.dart';
import 'package:tomatin/data/models/article.dart';

class DetailArticleScreen extends StatelessWidget {
  final int? articleId;

  const DetailArticleScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    final ArticleRepository articleRepository = ArticleRepository();

    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: FutureBuilder<Datum>(
        future: articleRepository.fetchArticleById(articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final article = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Header image
                      Container(
                        height: 265,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(article.imageCover ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF449D87),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: Text(
                                      article.disease?.diseaseName ??
                                          'Kategori',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    article.articleTitle ?? 'Judul Artikel',
                                    style: const TextStyle(
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
                              shape: const RoundedRectangleBorder(
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
                                    Text(
                                      article.articleContent ??
                                          'Konten tidak tersedia',
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      'Sumber referensi:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (article.articleUrl != null) {
                                          // Buka URL menggunakan library seperti `url_launcher`
                                        }
                                      },
                                      child: Text(
                                        article.articleUrl ?? 'Tidak ada link',
                                        style: const TextStyle(
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
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Data tidak ditemukan",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
