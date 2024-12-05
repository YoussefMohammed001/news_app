class PostsModelResponse {
  int userId = 0;
  int id = 0;
  String title = '';
  String body = '';

  PostsModelResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }


}
