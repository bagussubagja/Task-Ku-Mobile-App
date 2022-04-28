import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/models/article_model.dart';
import 'package:task_ku_mobile_app/screens/article_screen_detail/article_screen_detail.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  ArticleModel? articleModels;

  final List<String> topUrlImages = [
    'https://images.pexels.com/photos/1595385/pexels-photo-1595385.jpeg?cs=srgb&dl=pexels-fox-1595385.jpg&fm=jpg',
    'https://images.pexels.com/photos/826349/pexels-photo-826349.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-826349.jpg&fm=jpg',
    'https://images.pexels.com/photos/1015568/pexels-photo-1015568.jpeg?cs=srgb&dl=pexels-helena-lopes-1015568.jpg&fm=jpg',
    'https://images.pexels.com/photos/1181248/pexels-photo-1181248.jpeg?cs=srgb&dl=pexels-christina-morillo-1181248.jpg&fm=jpg',
    'https://images.pexels.com/photos/4050320/pexels-photo-4050320.jpeg?cs=srgb&dl=pexels-vlada-karpovich-4050320.jpg&fm=jpg',
  ];

  final List<String> topArticlesTitle = [
    'The Productivity Guide: Time Management Strategies That Work',
    'How to Make the Most of Your Workday',
    'How to Be More Productive at Work',
    'Be a Productive Programmer in Ramadan',
    '7 Tips to Be More Productive at School',
  ];

  final List<String> topArticlesLinks = [
    'https://jamesclear.com/productivity',
    'https://www.nytimes.com/guides/business/how-to-improve-your-productivity-at-work',
    'https://www.wsj.com/articles/how-to-be-more-productive-at-work-and-manage-your-time-effectively-11610743524',
    'https://medium.com/traideas/be-a-productive-programmer-in-ramadan-8ae0ba2d648a',
    'https://www.orchidsinternationalschool.com/blog/child-learning/seventips-to-be-more-productive-at-school/',
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
                itemCount: topUrlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = topUrlImages[index];
                  final articleTitle = topArticlesTitle[index];
                  final articleLink = topArticlesLinks[index];

                  // return buildImage(urlImage, articleTitle, articleDesc, index);
                  return buildImage(
                      urlImage, articleTitle, articleLink, index, context);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'New Article',
                      style: titleBlackStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text('See More..'))
                ],
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
                      final article = articleModel[index];
                      return Card(
                        child: ListTile(
                          leading: Container(
                            child: CachedNetworkImage(
                              imageUrl: article.imgUrl,
                              height: 50,
                              width: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          title: Text(
                            article.title,
                          ),
                          subtitle: Text(
                            article.content.length > 30
                                ? article.content.substring(0, 30) + '...'
                                : article.content,
                            style: regularStyle.copyWith(
                                color: greyColor, fontSize: 12),
                          ),
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

Widget buildImage(String urlImage, String articleTitle, String articleLink,
    int index, BuildContext context) {
  return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Container(
            child: CachedNetworkImage(
              imageUrl: urlImage,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.black12,
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          // Image.network(
          //   urlImage,
          //   fit: BoxFit.cover,
          // ),
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
                  style: titleStyle.copyWith(fontSize: 14),
                ),
                InkWell(
                  onTap: () async {
                    if (await launch(articleLink,
                        forceWebView: true, enableJavaScript: true)) {
                      debugPrint('done');
                    } else {
                      debugPrint('no');
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
      ));
}
