import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              //context.goNamed(AppRoutes.searchScreen);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppRoutes.searchScreen);
              },
              child: Text('search_button'.tr()),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppRoutes.articleDetailsScreen);
              },
              child: Text('article_details_button'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
