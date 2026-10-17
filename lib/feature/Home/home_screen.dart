import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_style.dart';
import 'package:news_app/feature/Home/widget/artical_card_widget.dart';
import 'package:news_app/feature/Home/widget/custom_category_item.dart';
import 'package:news_app/feature/Home/widget/top_head_line_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedCategoryIndex;
  void _selectCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

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
      body: Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 16.w),
            child: SizedBox(
              height: 40.h,
              child: ListView(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  CustomCageoryItem(
                    title: 'travel'.tr(),
                    onTap: () => _selectCategory(0),
                    isSelect: selectedCategoryIndex == 0,
                  ),
                  CustomCageoryItem(
                    title: 'technology'.tr(),
                    onTap: () => _selectCategory(1),
                    isSelect: selectedCategoryIndex == 1,
                  ),
                  CustomCageoryItem(
                    title: 'business'.tr(),
                    onTap: () => _selectCategory(2),
                    isSelect: selectedCategoryIndex == 2,
                  ),
                  CustomCageoryItem(
                    title: 'entertainment'.tr(),
                    onTap: () => _selectCategory(3),
                    isSelect: selectedCategoryIndex == 3,
                  ),
                  // Add more categories as needed
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TopHeadlineItemWidget(
              title: 'Apple Unveils Revolutionary AI Features ',
              authorName: 'omar abdeen',
              date: '2023-01-01',
              imageUrl: null,
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: ListView.builder(
                itemCount: 10, // Replace with your actual article count
                itemBuilder: (context, index) {
                  return ArticleCardWidget(
                    title: 'Article Title $index',
                    authorName: 'Author Name $index',
                    date: '2023-01-01',
                    imageUrl:
                        'https://img.magnific.com/free-vector/news-grunge-text_460848-9369.jpg?semt=ais_hybrid&w=740&q=80',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
