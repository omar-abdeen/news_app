import 'package:news_app/core/networking/api_constants.dart';
import 'package:news_app/core/networking/dio_helper.dart';
import 'package:news_app/feature/Home/model/top_headline_articles_model.dart';

class HomeService {
  Future<TopHeadlineArticlesModel> getTopHeadlinesArticles() async {
    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiConstants.topHeadlinesEndpoint,
        query: {'country': 'us', 'apiKey': ApiConstants.newsApiKey},
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        TopHeadlineArticlesModel topHeadlinesResponse =
            TopHeadlineArticlesModel.fromJson(response.data);
        return topHeadlinesResponse;
      } else {
        throw Exception('Failed to fetch top headlines');
      }
    } catch (e) {
      throw Exception('Failed to fetch top headlines: $e');
    }
  }
}
 