import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/models/article_model.dart';
import 'package:task_ku_mobile_app/screens/article_screen_detail/article_screen_detail.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  ArticleModel? articleModels;

  final List<String> urlImages = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  final List<String> articlesTitle = [
    'Judul 1',
    'Judul 2',
    'Judul 3',
    'Judul 4',
    'Judul 5',
    'Judul 6',
  ];

  final List<String> articlesDesc = [
    'ini desc 1',
    'ini desc 2',
    'ini desc 3',
    'ini desc 4',
    'ini desc 5',
    'ini desc 6',
  ];

  List<ArticleModel> articleModel = [
    ArticleModel(
        title: 'Judul 1',
        imgUrl:
            'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget egestas magna. Pellentesque ornare erat vitae lorem mattis, vel elementum justo facilisis. Praesent purus erat, pretium eget pharetra vel, imperdiet a dolor. Nam nec odio euismod, porttitor est non, vehicula ipsum. Nunc faucibus faucibus orci, ut semper orci auctor non. Vestibulum gravida, magna vitae sodales commodo, ipsum justo eleifend velit, sed suscipit risus odio id sem. Integer ligula nunc, maximus ac lorem sit amet, aliquet tincidunt augue. Sed interdum risus sem, quis dictum nulla semper id.'),
    ArticleModel(
        title: 'Judul 2',
        imgUrl:
            'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget egestas magna. Pellentesque ornare erat vitae lorem mattis, vel elementum justo facilisis. Praesent purus erat, pretium eget pharetra vel, imperdiet a dolor. Nam nec odio euismod, porttitor est non, vehicula ipsum. Nunc faucibus faucibus orci, ut semper orci auctor non. Vestibulum gravida, magna vitae sodales commodo, ipsum justo eleifend velit, sed suscipit risus odio id sem. Integer ligula nunc, maximus ac lorem sit amet, aliquet tincidunt augue. Sed interdum risus sem, quis dictum nulla semper id.'),
    ArticleModel(
        title: 'Judul 3',
        imgUrl:
            'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget egestas magna. Pellentesque ornare erat vitae lorem mattis, vel elementum justo facilisis. Praesent purus erat, pretium eget pharetra vel, imperdiet a dolor. Nam nec odio euismod, porttitor est non, vehicula ipsum. Nunc faucibus faucibus orci, ut semper orci auctor non. Vestibulum gravida, magna vitae sodales commodo, ipsum justo eleifend velit, sed suscipit risus odio id sem. Integer ligula nunc, maximus ac lorem sit amet, aliquet tincidunt augue. Sed interdum risus sem, quis dictum nulla semper id.'),
  ];

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
                style: titleBlackStyle.copyWith(fontSize: 22),
              ),
              Text(
                'Tempat dimana kamu bisa produktif!',
                style:
                    regularBlackStyle.copyWith(color: greyColor, fontSize: 14),
              ),
              SizedBox(
                height: 15,
              ),
              CarouselSlider.builder(
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];
                  final articleTitle = articlesTitle[index];
                  final articleDesc = articlesDesc[index];

                  // return buildImage(urlImage, articleTitle, articleDesc, index);
                  return buildImage(urlImage, articleTitle, articleDesc, index);
                },
                options: CarouselOptions(
                    autoPlay: true,
                    height: 180,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Top Article',
                  style: titleBlackStyle.copyWith(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: articleModel.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // final urlImage = urlImages[index];
                      // final articleTitle = articlesTitle[index];
                      // final articleDesc = articlesDesc[index];
                      final article = articleModel[index];
                      return Card(
                        child: ListTile(
                          leading: Container(
                            child: Image.network(article.imgUrl),
                          ),
                          title: Text(
                            article.title,
                          ),
                          subtitle: Text(article.content.length > 20
                              ? article.content.substring(0, 20) + '...'
                              : article.content),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ArticleScreenDetailPage(
                                  articleModel: article);
                            }));
                          },
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildImage(
    String urlImage, String articleTitle, String articleDesc, int index) {
  return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [Colors.black, Colors.black26],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articleTitle,
                  style: titleStyle.copyWith(fontSize: 16),
                ),
                Text(
                  articleDesc,
                  style: regularStyle.copyWith(fontSize: 13),
                )
              ],
            ),
          )
        ],
      ));
}
