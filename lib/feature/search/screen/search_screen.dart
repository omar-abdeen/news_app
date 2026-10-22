import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/networking/api_constants.dart';
import 'package:news_app/core/styles/app_text_style.dart';
import 'package:news_app/core/widgets/custom_text_field.dart';
import 'package:news_app/core/widgets/format_date.dart';
import 'package:news_app/feature/Home/widget/artical_card_widget.dart';
import 'package:news_app/feature/search/service/search_service.dart';
import 'package:news_app/model/article_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _searchService = SearchService();
  Future<ArticleModel>? _searchFuture;

  void _submitSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _searchFuture = _searchService.searchResults(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xffE9EEFA),
        elevation: 0,
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
           IconButton(
            onPressed: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale( Locale('ar'));
              } else {
                context.setLocale( Locale('en'));
              }
              ApiConstants.language = context.locale.languageCode;
            },
            icon: Icon(Icons.language_outlined, size: 23.sp),
          ),
        ],
        title: Text(
          'search'.tr(),
          style: AppTextStyles.titlesStyles.copyWith(fontSize: 24.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _searchController,
              width: double.infinity,
              hintText: 'search'.tr(),
              keyboardType: TextInputType.text,
              suffixIcon: IconButton(
                tooltip: 'search'.tr(),
                onPressed: _submitSearch,
                icon: const Icon(Icons.search_rounded),
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(child: _buildSearchContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchContent() {
    final future = _searchFuture;
    if (future == null) {
      return _SearchEmptyState(
        icon: Icons.manage_search_rounded,
        message: 'search'.tr(),
      );
    }

    return FutureBuilder<ArticleModel>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _SearchEmptyState(
            icon: Icons.error_outline_rounded,
            message: 'error'.tr(),
          );
        }

        final articles = snapshot.data?.articles ?? <ArticlesModel>[];
        if (articles.isEmpty) {
          return _SearchEmptyState(
            icon: Icons.article_outlined,
            message: 'no_results'.tr(),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.only(bottom: 20.h),
          itemCount: articles.length,
          separatorBuilder: (context, index) => SizedBox(height: 4.h),
          itemBuilder: (context, index) {
            final article = articles[index];
            return ArticleCardWidget(
              title: article.title ?? 'no_data'.tr(),
              authorName:
                  article.author ?? article.source?.name ?? 'no_data'.tr(),
              date: FormatDate().formatDate(article.publishedAt),
              imageUrl: article.urlToImage,
            );
          },
        );
      },
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const _SearchEmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64.sp, color: const Color(0xff9AA5B1)),
          SizedBox(height: 12.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.grey14Regular.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
