import 'package:news_app/core/networking/api_constants.dart';
import 'package:news_app/core/networking/dio_helper.dart';
import 'package:news_app/model/article_model.dart';

class SearchService {
  Future<ArticleModel> searchResults(String query) async {
    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiConstants.searchEndpoint,
        query: {'q': query, 'apiKey': ApiConstants.newsApiKey , 'language': ApiConstants.language},
      );
      if (response.statusCode == 200) {
        ArticleModel articleModel = ArticleModel.fromJson(response.data);
        return articleModel;
      } else {
        throw Exception('Failed to fetch top headlines');
      }
    } catch (e) {
      throw Exception('Failed to fetch top headlines: $e');
    }
  }
  Future<ArticleModel> getSearchResults({required String query}) async {
    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiConstants.searchEndpoint,
        query: {'q': query, 'apiKey': ApiConstants.newsApiKey},
      );
      if (response.statusCode == 200) {
        ArticleModel articleModel = ArticleModel.fromJson(response.data);
        return articleModel;
      } else {
        throw Exception('Failed to fetch top headlines');
      }
    } catch (e) {
      throw Exception('Failed to fetch top headlines: $e');
    }
  }
}
