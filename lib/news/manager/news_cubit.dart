import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:news_app/news/model/news_response.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final dio = Dio();

  void getNews({required String category}) async {
    emit(NewsLoading());
    try{
      final response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=909b3d38497c4cf281f6d015637a501e');
      print(response.statusCode);
        NewsResponseModel newsResponseModel = NewsResponseModel.fromJson(response.data);
        if (kDebugMode) {
          print(response);
          print("news response ${newsResponseModel.articles.length}");
        }
        emit(NewsSuccess(newsResponseModel));

    }catch(e){
      emit(NewsFailure(e.toString()));
      print(e);
    }



  }
}
