import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:news_app/posts/model/add_post_model_request.dart';
import 'package:news_app/posts/model/posts_model.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  final dio = Dio();

  getPosts() async {
    emit(PostsLoading());
    final response =
        await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      final List<PostsModelResponse> posts = (response.data as List).map((e) {
        return PostsModelResponse.fromJson(e);
      }).toList();
      print("posts: ${posts[0].title}");
      emit(PostsSuccess(posts));
    }
  }

  addPost({required AddPostModelRequest addPostModelRequest}) async {
    final response = await dio.delete(
        "https://jsonplaceholder.typicode.com/posts",
        data: addPostModelRequest.toJson()
    );
    print(response);
  }

  deletePost({required int id}) async {
    final response = await dio.delete(
        "https://jsonplaceholder.typicode.com/posts/$id"
    );
    print(response);
  }

}
