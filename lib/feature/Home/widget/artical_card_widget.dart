import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_style.dart';
import 'package:news_app/core/widgets/safe_network_image.dart';

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
                  maxLines: 2,
                  style: AppTextStyles.titlesStyles.copyWith(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                child: Text(
                  authorName.length > 20 ? '${authorName.substring(0, 20)}...' : authorName,
                  maxLines: 1,
                  style: AppTextStyles.grey14Regular.copyWith(),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                child: Text(
                  date,
                  maxLines: 1,
                  style: AppTextStyles.grey14Regular.copyWith(),
                ),
              ),
            ],
          ),
          SafeNetworkImage(
            imageUrl: imageUrl,
            width: 112.w,
            height: 80.h,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ],
      ),
    );
  }
}
