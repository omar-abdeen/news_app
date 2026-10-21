import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_style.dart';
import 'package:news_app/feature/Home/widget/artical_card_widget.dart';
import 'package:news_app/feature/search/service/search_service.dart';
import 'package:news_app/model/article_model.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;

  const SearchResultScreen({super.key, required this.query});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late final Future<dynamic> _searchResultsFuture;
  @override
  void initState() {
    _searchResultsFuture = SearchService().getSearchResults(
      query: widget.query,
    );
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of any resources here
    _searchResultsFuture.ignore(); // Ignore the future to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE9EEFA),
        //elevation: 0,
        toolbarHeight: 80.h,
        title: Center(
          child: Text(widget.query.tr(), style: AppTextStyles.white14SemiBold),
        ),
      ),
      body: FutureBuilder(
        future: _searchResultsFuture,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${asyncSnapshot.error}',
                style: AppTextStyles.white14SemiBold,
              ),
            );
          } else if (!asyncSnapshot.hasData ||
              (asyncSnapshot.data as ArticleModel).articles!.isEmpty) {
            return Center(
              child: Text(
                'No results found',
                style: AppTextStyles.white14SemiBold,
              ),
            );
          } else {
            ArticleModel articleModel = asyncSnapshot.data as ArticleModel;
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: ListView.builder(
                      itemCount: articleModel.articles!.length,
                      itemBuilder: (context, index) {
                        ArticlesModel article = articleModel.articles![index + 1];
                        return ArticleCardWidget(
                          title: article.title ?? 'No Title',
                          authorName: article.author ?? 'Unknown Author',
                          date: DateFormat(
                            'yyyy-MM-dd | HH:mm',
                          ).format(article.publishedAt ?? DateTime.now()),
                          imageUrl:
                              article.urlToImage ??
                              'https://img.magnific.com/free-vector/news-grunge-text_460848-9369.jpg?semt=ais_hybrid&w=740&q=80',
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
