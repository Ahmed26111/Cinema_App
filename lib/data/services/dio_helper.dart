import 'package:cinema_app/constants/api%20constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper{
  late final Dio dio;
  late final CacheOptions cacheOptions;

  DioHelper(){
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: Duration(seconds: 60),
      connectTimeout: Duration(seconds: 60),
    );

    cacheOptions = CacheOptions(
      store: MemCacheStore(),
      // Use request or refreshForceCache instead of forceCache
      policy: CachePolicy.request,
      maxStale: const Duration(hours: 2),
      // This allows the app to show old data if the internet is down
      hitCacheOnErrorExcept: [401, 403],
    );

    dio = Dio(baseOptions);
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode
    ));
  }

  Future<Response> getData  ({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }){
    return dio.get(path,data: data,queryParameters: query);
  }

  Future<Response> postData  ({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }){
    return dio.post(path,data: data,queryParameters: query);
  }

  Future<Response> putData  ({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }){
    return dio.put(path,data: data,queryParameters: query);
  }

  Future<Response> deleteData  ({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }){
    return dio.delete(path,data: data,queryParameters: query);
  }

}