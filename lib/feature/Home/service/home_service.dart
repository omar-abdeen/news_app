import 'package:news_app/core/networking/api_constants.dart';
import 'package:news_app/core/networking/dio_helper.dart';
import 'package:news_app/model/article_model.dart';

class HomeService {
  Future<ArticleModel> getTopHeadlinesArticles() async {
    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiConstants.topHeadlinesEndpoint,
        query: {'country': 'us', 'apiKey': ApiConstants.newsApiKey },
      );
      if (response.statusCode == 200 ) {
        ArticleModel articleModel =
            ArticleModel.fromJson(response.data);
        return articleModel;
      } else {
        throw Exception('Failed to fetch top headlines');
      }
    } catch (e) {
      throw Exception('Failed to fetch top headlines: $e');
    }
  }
}
 