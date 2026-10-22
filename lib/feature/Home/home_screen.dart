import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_text_style.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/feature/Home/service/home_service.dart';
import 'package:news_app/feature/Home/widget/artical_card_widget.dart';
import 'package:news_app/feature/Home/widget/custom_category_item.dart';
import 'package:news_app/feature/Home/widget/top_head_line_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedCategoryIndex;
  late final Future<ArticleModel> _headlinesFuture;

  void _selectCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  @override
  void initState() {
    _headlinesFuture = HomeService().getTopHeadlinesArticles();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of any resources here
    _headlinesFuture.ignore(); // Ignore the future to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE9EEFA),
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 80.h,
        title: Text('explore'.tr(), style: AppTextStyles.titlesStyles),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AppRoutes.searchScreen);
            },
            icon: const Icon(Icons.search),
          ),
        
        ],
      ),
      body: FutureBuilder<ArticleModel>(
        future: _headlinesFuture,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (asyncSnapshot.hasError) {
            return Center(child: Text('error'.tr()));
          } else if (asyncSnapshot.hasData) {
            final articleModel = asyncSnapshot.data!;
            if (articleModel.articles?.isEmpty == true) {
              return Center(child: Text('no_articles'.tr()));
            }
            return Column(
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 16.w),
                  child: SizedBox(
                    height: 40.h,
                    child: ListView(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        CustomCageoryItem(
                          title: 'travel'.tr(),
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.searchResultScreen,
                              queryParameters: {'query': 'travel'},
                            );
                            _selectCategory(0);
                          },
                          isSelect: selectedCategoryIndex == 0,
                        ),
                        CustomCageoryItem(
                          title: 'technology'.tr(),
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.searchResultScreen,
                              queryParameters: {'query': 'technology'},
                            );
                            _selectCategory(1);
                          },
                          isSelect: selectedCategoryIndex == 1,
                        ),
                        CustomCageoryItem(
                          title: 'business'.tr(),
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.searchResultScreen,
                              queryParameters: {'query': 'business'},
                            );
                            _selectCategory(2);
                          },
                          isSelect: selectedCategoryIndex == 2,
                        ),
                        CustomCageoryItem(
                          title: 'entertainment'.tr(),
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.searchResultScreen,
                              queryParameters: {'query': 'entertainment'},
                            );
                            _selectCategory(3);
                          },
                          isSelect: selectedCategoryIndex == 3,
                        ),
                        // Add more categories as needed
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TopHeadlineItemWidget(
                    title: articleModel.articles?[0].title ?? 'No Title',
                    authorName:
                        articleModel.articles?[0].author ?? 'Unknown Author',
                    date: DateFormat('yyyy-MM-dd | HH:mm').format(
                      articleModel.articles?[0].publishedAt ?? DateTime.now(),
                    ),
                    imageUrl:
                        articleModel.articles?[0].urlToImage ??
                        'https://img.magnific.com/free-vector/news-grunge-text_460848-9369.jpg?semt=ais_hybrid&w=740&q=80',
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: ListView.builder(
                      itemCount:
                          articleModel.articles!.length -
                          1, // Replace with your actual article count
                      itemBuilder: (context, index) {
                        ArticlesModel article =
                            articleModel.articles![index + 1];
                        return InkWell(
                          onTap: () {
                            // Navigate to the article details screen
                            context.pushNamed(
                              AppRoutes.articleDetailsScreen,
                              queryParameters: {
                                'title': article.title ?? '',
                                'author': article.author ?? '',
                                'publishedAt':
                                    article.publishedAt?.toIso8601String() ??
                                    '',
                                'description': article.description ?? '',
                                'urlToImage': article.urlToImage ?? '',
                              },
                            );
                          },
                          child: ArticleCardWidget(
                            title: article.title ?? 'No Title',
                            authorName: article.author ?? 'Unknown Author',
                            date: DateFormat(
                              'yyyy-MM-dd | HH:mm',
                            ).format(article.publishedAt ?? DateTime.now()),
                            imageUrl:
                                article.urlToImage ??
                                'https://img.magnific.com/free-vector/news-grunge-text_460848-9369.jpg?semt=ais_hybrid&w=740&q=80',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        },
      ),
    );
  }
}
