import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:news_app/posts/model/posts_model.dart';

part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit() : super(PostDetailsInitial());
final dio =Dio();



getPostDetails(int id)async{
  emit(PostDetailsLoading());
  try{
    final response=await dio.get('https://jsonplaceholder.typicode.com/posts/$id');
    final postDetails = PostsModelResponse.fromJson(response.data);
    emit(PostDetailsLoaded(postDetails));
  }catch(e) {
    emit(PostDetailsError(e.toString()));
  }
}

}
