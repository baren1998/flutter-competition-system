import 'package:dio/dio.dart';
import 'dart:async';

Future request(url, {queryParams}) async {
  try {
    Dio dio = new Dio();
    Response response;
    if(queryParams != null) {
      response = await dio.get(url, queryParameters: queryParams);
    } else {
      response = await dio.get(url);
    }
    if(response.statusCode == 200) {
//      print(response.data.toString());
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch(e) {
    return print('ERROR: ========>${e}');
  }
}

Future post(url, requestBody) async {
  try {
    Dio dio = new Dio();
    Response response;
    response = await dio.post(url, queryParameters: requestBody);
    if(response.statusCode == 200) {
//      print(response.data.toString());
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch(e) {
    return print('ERROR: ========>${e}');
  }
}