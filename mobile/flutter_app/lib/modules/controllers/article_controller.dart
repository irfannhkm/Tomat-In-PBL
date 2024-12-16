import 'package:get/get.dart';
import '../../data/repositories/article_repository.dart';
import '../../data/models/article.dart';

class ArticleController extends GetxController {
  final ArticleRepository repository;

  // Observable untuk artikel
  var articles = <Datum>[].obs;
  var isLoading = false.obs;
  var selectedArticle = Rx<Datum?>(null);

  ArticleController(this.repository);

  // Fetch all articles
  Future<void> loadArticles() async {
    try {
      isLoading.value = true;
      articles.value = await repository.fetchAllArticles();
    } catch (e) {
      Get.snackbar("Error", "Failed to load articles: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch article by ID
  Future<void> loadArticleById(int id) async {
    try {
      selectedArticle.value = await repository.fetchArticleById(id);
    } catch (e) {
      Get.snackbar("Error", "Failed to load article details: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadArticles(); // Load articles saat controller diinisialisasi
  }
}
