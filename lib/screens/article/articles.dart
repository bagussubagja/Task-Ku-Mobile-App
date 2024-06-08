// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/models/article_model.dart';
import 'package:task_ku_mobile_app/models/top_articles_model.dart';
import 'package:task_ku_mobile_app/screens/article/article_list_screen.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task-Ku Articles',
                style: titleStyle.copyWith(fontSize: 22),
              ),
              Text(
                'A place where you can be productive!',
                style:
                    regularBlackStyle.copyWith(color: greyColor, fontSize: 14),
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<List<TopArticlesModel>>(
                  stream: readTopArticles(),
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.hasError) {
                        return Text('Something error ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final tops = snapshot.data!;
                        return CarouselSlider.builder(
                            itemCount: tops.length,
                            itemBuilder: (context, index, realIndex) {
                              return buildTopArticleModel(
                                  tops[index], index, context);
                            },
                            options: CarouselOptions(
                                autoPlay: true,
                                height: 180,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height));
                      } else if (!snapshot.hasData) {
                        return const Text('No data!');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    } catch (e) {
                      return Text(e.toString());
                    }
                  }),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      'New Article',
                      style: titleStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ArticleListScreen();
                        }));
                      },
                      child: const Text('See More..'))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: StreamBuilder<List<ArticleModel>>(
                    stream: readArticles(),
                    builder: (context, snapshot) {
                      try {
                        if (snapshot.hasError) {
                          return Text('Something error ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final articles = snapshot.data!;
                          return ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) => buildArticles(
                                  articles[index], index, context));
                        } else if (!snapshot.hasData) {
                          return const Text('No Data');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      } catch (e) {
                        return Text(e.toString());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Stream<List<TopArticlesModel>> readTopArticles() {
  return FirebaseFirestore.instance
      .collection('top-articles')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((e) => TopArticlesModel.fromJson(e.data()))
        .toList();
  });
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

Widget buildTopArticleModel(
    TopArticlesModel topArticlesModel, int index, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: Stack(
      children: [
        SizedBox(
          child: CachedNetworkImage(
            imageUrl: topArticlesModel.imgUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.black12,
              child: const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Container(
          height: 180,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [Colors.black, Colors.black26],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topArticlesModel.title,
                style: titleStyle.copyWith(fontSize: 14),
              ),
              InkWell(
                onTap: () async {
                  if (await launch(topArticlesModel.link,
                      forceWebView: true, enableJavaScript: true)) {
                    debugPrint('Open');
                  } else {
                    debugPrint('No');
                  }
                },
                child: Text(
                  'Read More...',
                  style: regularStyle.copyWith(fontSize: 13),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
