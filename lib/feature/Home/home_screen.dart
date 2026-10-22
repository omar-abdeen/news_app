import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_text_style.dart';
import 'package:news_app/feature/Home/widget/error_handle.dart';
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
  late Future<ArticleModel> _headlinesFuture;

  void _selectCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHeadlines();
  }

  void _loadHeadlines() {
    _headlinesFuture = HomeService().getTopHeadlinesArticles();
  }

  Future<void> _refreshHeadlines() async {
    setState(_loadHeadlines);
    try {
      await _headlinesFuture;
    } on Exception {
      // FutureBuilder displays the localized error state below.
    }
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
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
                ),
              ],
            );
          } else if (asyncSnapshot.hasError) {
            return ErrorHandle(refresh: _refreshHeadlines);
          } else if (asyncSnapshot.hasData) {
            final articleModel = asyncSnapshot.data!;
            final articles = articleModel.articles ?? [];
            if (articles.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 240.h),
                  Center(child: Text('no_articles'.tr())),
                ],
              );
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
                    title: articles[0].title ?? 'No Title',
                    authorName: articles[0].author ?? 'Unknown Author',
                    date: DateFormat(
                      'yyyy-MM-dd | HH:mm',
                    ).format(articles[0].publishedAt ?? DateTime.now()),
                    imageUrl:
                        articles[0].urlToImage ??
                        'https://img.magnific.com/free-vector/news-grunge-text_460848-9369.jpg?semt=ais_hybrid&w=740&q=80',
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshHeadlines,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: articles.length - 1,
                      itemBuilder: (context, index) {
                        final article = articles[index + 1];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w),
                          child: InkWell(
                            onTap: () {
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        },
      ),
    );
  }
}
