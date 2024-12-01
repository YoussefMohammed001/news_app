part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}
final class NewsLoading extends NewsState {}
final class NewsSuccess extends NewsState {
  final NewsResponseModel newsResponseModel;
  NewsSuccess(this.newsResponseModel);
}
final class NewsFailure extends NewsState {
  final String message;

  NewsFailure(this.message);
}
