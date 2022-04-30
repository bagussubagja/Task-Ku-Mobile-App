class ArticleModel {
  final String title;
  final String imgUrl;
  final String desc;
  final String link;

  ArticleModel({
    required this.title,
    required this.imgUrl,
    required this.desc,
    required this.link
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'imgUrl': imgUrl,
    'desc': desc,
    'link': link,
  };

  static ArticleModel fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      imgUrl: json['imgUrl'],
      desc: json['desc'],
      link: json['link'],
    );
  }
}
