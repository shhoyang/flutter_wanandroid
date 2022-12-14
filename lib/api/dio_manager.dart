import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/http_code.dart';
import 'package:flutter_wanandroid/global_config.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// 单例
class DioManager {

  DioManager._privateConstructor();

  static final DioManager _instance = DioManager._privateConstructor();

  factory DioManager(){
    return _instance;
  }

  late Dio _dio;

  late PersistCookieJar _cookieJar;

  clearCookies() {
    _cookieJar.deleteAll();
  }

  Future<List<Cookie>> getCookies() async {
    return _cookieJar
        .loadForRequest(Uri.parse(ApiService.base + ApiService.login));
  }

  get(String url, Function successCallBack,
      {Map<String, dynamic>? params, Function? errorCallBack}) async {
    _request(url, "get", successCallBack,
        params: params, errorCallBack: errorCallBack);
  }

  post(String url, Function successCallBack,
      {Map<String, dynamic>? params, Function? errorCallBack}) async {
    _request(url, "post", successCallBack,
        params: params, errorCallBack: errorCallBack);
  }

  _request(String url,
      String method,
      Function successCallBack, {
        Map<String, dynamic>? params,
        Function? errorCallBack,
      }) async {
    Response? response;

    try {
      if ("get" == method) {
        response = await _dio.get(url, queryParameters: params);
      } else if ("post" == method) {
        response = await _dio.post(url, queryParameters: params);
      }
    } on DioError catch (error) {
      Response errorResponse = error.response ??
          Response(
              statusCode: HttpCode.HTTP_ERROR,
              requestOptions: RequestOptions(path: url));

      if (error.type == DioErrorType.sendTimeout) {
        errorResponse.statusCode = HttpCode.HTTP_CONNECT_TIMEOUT;
      } else if (error.type == DioErrorType.receiveTimeout) {
        errorResponse.statusCode = HttpCode.HTTP_RECEIVE_TIMEOUT;
      }

      if (GlobalConfig.isDebug) {
        print("请求异常：" + error.toString());
        print("请求异常url：" + url);
      }

      _error(errorCallBack, errorResponse.statusCode, "网络异常");
      return "";
    }

    if (GlobalConfig.isDebug) {
      print("请求url: " + url);
      if (params != null) {
        print("请求参数: $params");
      }
      if (response != null) {
        print("请求结果: $response");
      }
    }

    String dataStr = json.encode(response?.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap["errorCode"] != HttpCode.SUCCESS) {
      _error(errorCallBack, dataMap["errorCode"], dataMap["errorMsg"]);
    } else {
      successCallBack(dataMap["data"]);
    }
  }

  _error(Function? errorCallBack, int? errorCode, String errorMsg) {
    if (errorCallBack != null) {
      errorCallBack(errorCode, errorMsg);
    }
  }

  Future<void> initConfig() async {
    _dio = Dio();
    _dio.interceptors.add(LogInterceptor());
    _dio.options
      ..headers = {}
      ..baseUrl = ApiService.base
      ..connectTimeout = 10000
      ..receiveTimeout = 10000;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String cookiesPath = join(appDocDir.path, ".cookies");
    _cookieJar = PersistCookieJar(storage: FileStorage(cookiesPath));
    _dio.interceptors.add(CookieManager(_cookieJar));
  }
}
