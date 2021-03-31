import 'package:dio/dio.dart';
import 'package:flutter2_demo/app_config.dart';

class MyDio {
  Future getRequestFunction(Map<String,dynamic> param) async {
    Dio dio = new Dio();
    String url = "${ENV.baseUrl}/login";
    Response response = await dio.get(url, queryParameters: param);
    var data = response.data;
    return data;
  }

  Future postRequestFunction(Map<String,dynamic> param) async {
    Dio dio = new Dio();
    String url = "${ENV.baseUrl}/login";
    Response response = await dio.post(url, data: param);
    var data = response.data;
    return data;
  }
}

