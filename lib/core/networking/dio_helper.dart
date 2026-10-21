import 'dart:math';
import 'package:dio/dio.dart';
import 'package:news_app/core/networking/api_constants.dart';

class DioHelper {
  static Dio? dio;
  static initDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
     
  }

  static getRequest({
    required String endPoint,
    required Map<String, dynamic> query,
  }) async {
    try {
      Response response = await dio!.get(endPoint, queryParameters: query);

      return response;
    } catch (e) {
      log('Error in GET request: $e' as num);
    }
  }
  static postRequest({
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
      log('Error in POST request: $e' as num);
    }
  }
}
