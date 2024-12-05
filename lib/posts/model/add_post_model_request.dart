class AddPostModelRequest {
  final String title;
  final String body;
  AddPostModelRequest({required this.title, required this.body});

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
      };
}
