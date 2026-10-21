import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_style.dart';
import 'package:news_app/core/widgets/safe_network_image.dart';

class TopHeadlineItemWidget extends StatelessWidget {
  final String title;
  final String authorName;
  final String date;
  final String? imageUrl;
  const TopHeadlineItemWidget({
    super.key,
    required this.title,
    required this.authorName,
    required this.date,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: SafeNetworkImage(
            imageUrl: imageUrl,
            height: 206.h,
            width: double.infinity,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          title,
          style: AppTextStyles.titlesStyles.copyWith(
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "$authorName . $date",
          style: AppTextStyles.grey14Regular.copyWith(),
        ),
      ],
    );
  }
}
