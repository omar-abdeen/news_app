import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/feature/Home/home_screen.dart';
import 'package:news_app/feature/article_details/screens/article_details_screen.dart';
import 'package:news_app/feature/search/screen/search_screen.dart';
import 'package:news_app/feature/search_result/screen/search_result_screen.dart';
import 'package:news_app/model/article_model.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.homeScreen,
    routes: [
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.searchScreen,
        name: AppRoutes.searchScreen,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.searchResultScreen,
        name: AppRoutes.searchResultScreen,
        builder: (context, state) =>
            SearchResultScreen(query: state.uri.queryParameters['query'] ?? ''),
      ),
      GoRoute(
        path: AppRoutes.articleDetailsScreen,
        name: AppRoutes.articleDetailsScreen,
        builder: (context, state) => ArticleDetailsScreen(
          article: ArticlesModel(
            title: state.uri.queryParameters['title'] ?? '',
            author: state.uri.queryParameters['author'] ?? '',
            publishedAt: DateTime.tryParse(
              state.uri.queryParameters['publishedAt'] ?? '',
            ),
            description: state.uri.queryParameters['description'] ?? '',
            urlToImage: state.uri.queryParameters['urlToImage'] ?? '',
          ),
        ),
      ),
    ],
  );
}
