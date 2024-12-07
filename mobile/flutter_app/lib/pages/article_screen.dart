import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatin/bloc/article/article_bloc.dart';
import 'package:tomatin/data/models/article.dart';
import 'package:tomatin/data/models/videos.dart';
import 'package:tomatin/data/repository/article_repository.dart';
import 'package:tomatin/pages/detail_article_screen.dart';
import '../bloc/article/article_event.dart';
import '../bloc/article/article_state.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ArticleBloc(ArticleRepository())..add(FetchArticles()),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xFF1A1D26),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Artikel dan Video',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Articles'),
                      Tab(text: 'Videos'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<ArticleBloc, ArticleState>(
                      builder: (context, state) {
                        if (state is ArticleLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is ArticleLoaded) {
                          final articles = state.articles;
                          final videos = state.videos;
                          return TabBarView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: videos.length,
                                      itemBuilder: (context, index) {
                                        final video = videos[index];
                                        return Container(
                                          width: 200,
                                          margin:
                                              const EdgeInsets.only(right: 16),
                                          child: InkWell(
                                            onTap: () {
                                              // Open video player or YouTube URL
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  video.thumbnailUrl.toString(),
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: 200,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(
                                                          Icons.video_library,
                                                          size: 100),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  video.videoTitle.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  _buildArticleList(articles),
                                ],
                              ),
                              // Filter Articles: Artikel scroll atas-bawah
                              _buildArticleList(articles),
                              // Filter Videos: Video scroll atas-bawah
                              Expanded(
                                child: ListView.builder(
                                  itemCount: videos.length,
                                  itemBuilder: (context, index) {
                                    final video = videos[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      child: InkWell(
                                        onTap: () {
                                          // Open video player or YouTube URL
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              video.thumbnailUrl.toString(),
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: double.infinity,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Icon(
                                                      Icons.video_library,
                                                      size: 150),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              video.videoTitle.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else if (state is ArticleError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoSection(List<VideoDatum> videos) {
    return ListView.builder(
      shrinkWrap: true, // Agar tinggi widget menyesuaikan isi
      physics:
          const NeverScrollableScrollPhysics(), // Nonaktifkan scroll mandiri
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              // Open video player or YouTube URL
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  video.thumbnailUrl.toString(),
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.video_library, size: 100),
                ),
                const SizedBox(height: 4),
                Text(
                  video.videoTitle.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildArticleList(List<Datum> articles) {
    return Expanded(
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ArticleCard(
            articleId: article.id,
            title: article.articleTitle ?? 'No Title',
            category: article.disease?.diseaseName ?? 'No Category',
            imagePath: article.imageCover ?? 'assets/tomato_article.png',
          );
        },
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final int? articleId;
  final String title;
  final String category;
  final String imagePath;

  const ArticleCard({
    super.key,
    required this.articleId,
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
            builder: (context) => DetailArticleScreen(articleId: articleId),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFDAF1DE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagePath.startsWith('http')
                ? Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 150,
                      color: Colors.grey,
                    ),
                  )
                : Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
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
