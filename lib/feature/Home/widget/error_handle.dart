import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_style.dart';

class ErrorHandle extends StatelessWidget {
  final VoidCallback refresh;
  const ErrorHandle({super.key , required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(height: 180.h),
          Icon(Icons.wifi_off_rounded, size: 56.sp, color: Colors.blueGrey),
          SizedBox(height: 16.h),
          Text(
            'network_error'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.black14SemiBold,
          ),
          SizedBox(height: 16.h),
          ElevatedButton.icon(
            onPressed: refresh,
            icon: const Icon(Icons.refresh),
            label: Text('retry'.tr()),
          ),
        ],
      ),
    );
  }
}
