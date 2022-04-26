import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/models/article_model.dart';

class ArticleScreenDetailPage extends StatelessWidget {
  final ArticleModel articleModel;
  const ArticleScreenDetailPage({Key? key, required this.articleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Image.network(articleModel.imgUrl),
            Text(articleModel.title),
            Text(articleModel.content),
          ],
        ),
      )),
    );
  }
}
