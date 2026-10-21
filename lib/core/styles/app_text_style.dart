import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/styles/app_colors.dart';

class AppTextStyles {
  static TextStyle titlesStyles = GoogleFonts.inter(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff231F20),
  );
  static TextStyle onBoardingDescriptionStyle = GoogleFonts.inter(
    fontSize: 13.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.blackColor,
  );

  static TextStyle white14SemiBold = GoogleFonts.inter(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );
  static TextStyle black14SemiBold = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );

  static TextStyle grey14Regular = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: const Color(0xff878787),
  );
}
