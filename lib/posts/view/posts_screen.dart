import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/post_details/screen/post_details_screen.dart';
import 'package:news_app/posts/manager/posts_cubit.dart';
import 'package:news_app/posts/model/add_post_model_request.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final cubit = PostsCubit();
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getPosts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
        ),
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Form(
                      key: formKey,
                      child: AlertDialog(
                        title: const Text("Add Post"),
                        content: SizedBox(
                          height: 140,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: titleController,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Please enter title";
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(hintText: "Title"),
                              ),
                              TextFormField(
                                controller: bodyController,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Please enter body";
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(hintText: "body"),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.addPost(
                                      addPostModelRequest: AddPostModelRequest(
                                          title: titleController.text,
                                          body: bodyController.text));
                                  Navigator.pop(context);
                                  titleController.clear();
                                  bodyController.clear();
                                }
                              },
                              child: const Text("Add")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"))
                        ],
                      ),
                    );
                  });
            }),
        body: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostsSuccess && state.posts.isNotEmpty) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      print(state.posts[index].id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDetailsScreen(
                                    postId: state.posts[index].id,
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.deletePost(id: state.posts[index].id);
                            },
                            child: Container(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ),
                          Text(
                            state.posts[index].title,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(state.posts[index].body),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is PostsSuccess && state.posts.isEmpty) {
              return const Text("No posts yet");
            } else {
              return const Center(child: Text("Error"));
            }
          },
        ),
      ),
    );
  }
}
