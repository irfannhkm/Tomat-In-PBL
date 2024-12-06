import 'package:tomatin/data/models/article.dart';
import 'package:tomatin/data/models/videos.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Datum> articles;
  final List<VideoDatum> videos;

  ArticleLoaded(this.articles, this.videos);
}

class ArticleError extends ArticleState {
  final String message;
  ArticleError(this.message);
}
