import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news/manager/news_cubit.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

final cubit = NewsCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
    cubit
        ..getNews(category: "science"),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){
                  cubit..getNews(category: "general");
                }, child: const Text("general"))),
                Expanded(child: ElevatedButton(onPressed: (){
                  cubit..getNews(category: "sports");
                }, child: const Text("sports"))),
                Expanded(child: ElevatedButton(onPressed: (){
                  cubit..getNews(category: "business");
                }, child: const Text("business"))),
                Expanded(child: ElevatedButton(onPressed: (){
                  cubit..getNews(category: "entertainment");
                }, child: const Text("science"))),




              ],
              ),


              BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if(state is NewsLoading){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if(state is NewsSuccess){
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) =>
                            Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text("New York post",
                                        style: TextStyle(

                                            color: Colors.white
                                        ),
                                      )),
                                  Image.network(
                                    state.newsResponseModel.articles[index].urlToImage.toString(),
                                  height: 200,width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),

                                   Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(state.newsResponseModel.articles[index].author,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          state.newsResponseModel.articles[index].title,),
                                        const Divider(),
                                        Text(
                                          state.newsResponseModel.articles[index].content,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                    );
                  } else if(state is NewsFailure){
                    return Text(state.message);
                  }else{
                    return Container();
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
