import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_style.dart';

class CustomCageoryItem extends StatelessWidget {
  const CustomCageoryItem({
    super.key,
    required this.title,
    required this.isSelect,
    required this.onTap,
  });

  final String title;
  final bool isSelect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 5.h),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE9EEFA), width: 2.w),
            color: isSelect ? const Color(0xffE9EEFA) : Colors.transparent,
            borderRadius: BorderRadius.circular(56.r),
          ),
          child: Text(title, style: AppTextStyles.black14SemiBold),
        ),
      ),
    );
  }
}
