import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_style.dart';

class ArticleCardWidget extends StatelessWidget {
  final String title;
  final String authorName;
  final String date;
  final String? imageUrl;
  const ArticleCardWidget({
    super.key,
    required this.title,
    required this.authorName,
    required this.date,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  title,
                  style: AppTextStyles.titlesStyles.copyWith(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                child: Text(
                  "$authorName . $date",
                  style: AppTextStyles.grey14Regular.copyWith(),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 112.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl:
                    imageUrl ??
                    "https://static.toiimg.com/photo/msid-109960309/109960309.jpg",
                height: 80.h,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
