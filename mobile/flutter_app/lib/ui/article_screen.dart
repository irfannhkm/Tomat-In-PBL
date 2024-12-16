import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/modules/controllers/article_controller.dart';
import 'package:tomatin/modules/controllers/video_controller.dart';
import 'package:tomatin/data/repositories/article_repository.dart';
import 'package:tomatin/data/models/article.dart';
import 'package:tomatin/data/models/videos.dart';
import 'package:tomatin/data/repositories/video_repository.dart';
import 'package:tomatin/ui/detail_article_screen.dart';
import 'package:tomatin/ui/videoplayer_screen.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticleController articleController =
        Get.put(ArticleController(ArticleRepository()));
    final VideoController videoController =
        Get.put(VideoController(VideoRepository()));

    return DefaultTabController(
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
                  'Artikel & Video',
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
                  child: Obx(() {
                    if (articleController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return TabBarView(
                      children: [
                        _buildAllContent(
                          articleController.articles,
                          videoController.videos,
                        ),
                        _buildArticleList(articleController.articles),
                        _buildVideoList(videoController.videos),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllContent(List<Datum> articles, List<VideoDatum> videos) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal Video List
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => YoutubeVideoScreen(
                        videoUrl: video.videoUrl.toString()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          video.getThumbnailUrl(),
                          fit: BoxFit.cover,
                          width: 200,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey,
                            width: 200,
                            height: 100,
                            child: const Center(
                              child: Icon(Icons.error, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          video.videoTitle ?? 'No Title',
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
          const SizedBox(height: 20),

          // Vertical Article List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleCard(
                articleId: article.id,
                title: article.articleTitle ?? 'No Title',
                category: article.disease?.diseaseName ?? 'No Category',
                imagePath:
                    article.imageCover ??
                    'assets/tomato_article.png',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArticleList(List<Datum> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleCard(
          articleId: article.id,
          title: article.articleTitle ?? 'No Title',
          category: article.disease?.diseaseName ?? 'No Category',
          imagePath:
              article.imageCover ??
              'assets/tomato_article.png',
        );
      },
    );
  }

  Widget _buildVideoList(List<VideoDatum> videos, {bool isHorizontal = false}) {
    return ListView.builder(
      scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return InkWell(
          onTap: () {
            Get.to(
                () => YoutubeVideoScreen(videoUrl: video.videoUrl.toString()));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: isHorizontal ? 200 : double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  video.getThumbnailUrl(),
                  fit: BoxFit.cover,
                  height: isHorizontal ? 100 : 150,
                  width: isHorizontal ? 200 : double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.video_library, size: 100),
                ),
                const SizedBox(height: 4),
                Text(
                  video.videoTitle.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
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
        Get.to(DetailArticleScreen(articleId: articleId));
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
            _buildImage(imagePath),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category,
                      style: const TextStyle(
                          color: Color(0xFF2F776B), fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Color(0xFF2F776B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String path) {
    return path.startsWith('http')
        ? Image.network(
            path,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported,
                size: 150,
                color: Colors.grey),
          )
        : Image.asset(path,
            fit: BoxFit.cover, height: 150, width: double.infinity);
  }
}
