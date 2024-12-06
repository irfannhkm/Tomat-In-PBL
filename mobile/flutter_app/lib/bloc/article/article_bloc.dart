import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/article_repository.dart';
import '../../data/models/article.dart';
import '../../data/models/videos.dart';
import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc(this.articleRepository) : super(ArticleInitial()) {
    on<FetchArticles>(_onFetchArticles);
  }

  Future<void> _onFetchArticles(
      FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    try {
      final articles = await articleRepository
          .fetchAllArticles(); // Pastikan fungsi ini mengembalikan model Article
      final videos = await articleRepository.fetchAllVideos();

      var articles2 = articles as List<Datum>;
      var videos2 = videos as List<VideoDatum>;
      emit(ArticleLoaded(
          articles2, videos2)); // Mengambil list data artikel dari response
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
