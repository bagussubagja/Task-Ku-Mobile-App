// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/models/article_model.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Article List Screen',
          style: titleStyle.copyWith(fontSize: 20),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<List<ArticleModel>>(
                  stream: readArticles(),
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.hasError) {
                        return Text('Something error ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final articles = snapshot.data!;
                        return ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) =>
                              buildArticles(articles[index], index, context),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                        );
                      } else if (!snapshot.hasData) {
                        return const Text('No Data');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    } catch (e) {
                      return Text(e.toString());
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }

  Stream<List<ArticleModel>> readArticles() {
    return FirebaseFirestore.instance
        .collection('articles')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => ArticleModel.fromJson(e.data())).toList();
    });
  }

  Widget buildArticles(
      ArticleModel articleModel, int index, BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          child: CachedNetworkImage(
            imageUrl: articleModel.imgUrl,
            height: 50,
            width: 80,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        title: Text(
          articleModel.title,
          style: regularStyle.copyWith(fontSize: 14),
        ),
        subtitle: Text(
          articleModel.desc.length > 30
              ? '${articleModel.desc.substring(0, 30)}...'
              : articleModel.desc,
          style: regularStyle.copyWith(color: greyColor, fontSize: 12),
        ),
        onTap: () async {
          if (await launch(articleModel.link,
              forceWebView: true, enableJavaScript: true)) {
            debugPrint('done');
          } else {
            debugPrint('no');
          }
        },
      ),
    );
  }
}
