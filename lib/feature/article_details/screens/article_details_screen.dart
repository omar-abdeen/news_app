import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_style.dart';
import 'package:news_app/core/widgets/format_date.dart';
import 'package:news_app/core/widgets/safe_network_image.dart';
import 'package:news_app/model/article_model.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final ArticlesModel article;

  const ArticleDetailsScreen({super.key, required this.article});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final body = widget.article.content?.trim().isNotEmpty == true
        ? widget.article.content!
        : widget.article.description?.trim().isNotEmpty == true
        ? widget.article.description!
        : 'No Description';
    final imageHeight = (MediaQuery.sizeOf(context).width * 1.12).clamp(
      400.h,
      520.h,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeNetworkImage(
              imageUrl: widget.article.urlToImage,
              width: double.infinity,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
            Transform.translate(
              offset: Offset(0, -32.h),
              transformHitTests: false,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24.w, 42.h, 24.w, 36.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(42.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.article.title?.trim().isNotEmpty == true
                          ? widget.article.title!
                          : 'No Title',
                      style: AppTextStyles.titlesStyles.copyWith(
                        fontSize: 27.sp,
                        height: (1.2).h,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Text(
                      '${widget.article.author?.trim().isNotEmpty == true ? widget.article.author : 'Unknown author'} · ${FormatDate().formatDate(widget.article.publishedAt)}',
                      style: AppTextStyles.grey14Regular.copyWith(
                        fontSize: 16.sp,
                        height:( 1.4).h,
                      ),
                    ),
                    SizedBox(height: 46.h),
                    Text(
                      body,
                      style: TextStyle(
                        color: const Color(0xff2b2728),
                        fontFamily: 'serif',
                        fontSize: 22.sp,
                        height: (1.55).h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
