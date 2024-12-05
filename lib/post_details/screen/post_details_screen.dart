import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/post_details/manger/post_details_cubit.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen({super.key, required this.postId});

  final int postId;
  final cubit = PostDetailsCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getPostDetails(postId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Post Details"),
        ),
        body: BlocBuilder<PostDetailsCubit, PostDetailsState>(
          builder: (context, state) {
            if(state is PostDetailsLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is PostDetailsLoaded){
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.postModel.title,
                    style: const TextStyle(
                      color: Colors.red
                      ,fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(height: 20,),
                    Text(state.postModel.body),
                  ],
                ),
              );
            } else{
              return Container();
            }
          },
        ),
      ),
    );
  }
}
