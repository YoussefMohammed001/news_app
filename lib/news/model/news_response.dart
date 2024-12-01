class NewsResponseModel {
   int totalResults = 0;
  String status = "";
  List<ArticlesModel> articles = [];


  NewsResponseModel.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    status = json['status'];
    if (json['articles'] != null) {
      articles = <ArticlesModel>[];
      json['articles'].forEach((v) {
        articles.add(ArticlesModel.fromJson(v));
      });
    }
  }



}

class ArticlesModel {
String author = "";
String title = "";
String description = "";
String url = "";
String urlToImage = "";
String publishedAt = "";
String content = "";

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    author = json['author'] ?? "";
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    url = json['url'] ??"";
    urlToImage = json['urlToImage'] ??  "https://s.hdnux.com/photos/01/46/20/62/26807432/3/rawImage.jpg";
    publishedAt = json['publishedAt'] ?? "";
    content = json['content'] ?? " ";
  }


}
