part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsSuccess extends PostsState {
  final List<PostsModelResponse> posts;
  PostsSuccess(this.posts);
}

final class PostsError extends PostsState {}
