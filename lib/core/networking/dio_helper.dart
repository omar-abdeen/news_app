import 'package:dio/dio.dart';
import 'package:news_app/core/networking/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class DioHelper {
  static Dio? dio;
  static initDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
     dio!.interceptors.add(PrettyDioLogger());
  }

  static Future<Response<dynamic>> getRequest({
    required String endPoint,
    required Map<String, dynamic> query,
  }) async {
    try {
      Response response = await dio!.get(endPoint, queryParameters: query);

      return response;
    } catch (e) {
      // log('Error in GET request: $e' as num);
      return Future.error(e);
    }
  }
  static Future<Response<dynamic>> postRequest({
    required String endPoint,
    required Map<String, dynamic> query,
    required Map<String, dynamic> body,
  }) async {
    try {
      Response response = await dio!.post(
        endPoint,
        queryParameters: query,
        data: body,
      );

      return response;
    } catch (e) {
      
      return Future.error(e);
    }
  }
}
