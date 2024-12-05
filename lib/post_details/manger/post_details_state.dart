part of 'post_details_cubit.dart';

@immutable
sealed class PostDetailsState {}

final class PostDetailsInitial extends PostDetailsState {}

final class PostDetailsLoading extends PostDetailsState {}

final class PostDetailsLoaded extends PostDetailsState {
  final PostsModelResponse postModel;
  PostDetailsLoaded(this.postModel);
}

final class PostDetailsError extends PostDetailsState {
  final String errorMessage;
  PostDetailsError(this.errorMessage);
}