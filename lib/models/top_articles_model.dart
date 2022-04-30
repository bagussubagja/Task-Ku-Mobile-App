class TopArticlesModel {
  String id;
  final String title;
  final String imgUrl;
  final String link;

  TopArticlesModel(
      {this.id = '',
      required this.title,
      required this.imgUrl,
      required this.link});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imgUrl': imgUrl,
        'link': link,
      };

  static TopArticlesModel fromJson(Map<String, dynamic> json) {
    return TopArticlesModel(
      title: json['title'],
      imgUrl: json['imgUrl'],
      link: json['link'],
    );
  }
}
