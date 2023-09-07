import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'custom_exception.dart';

class ApiProvider {
// next three lines makes this class a Singleton
  static final ApiProvider _instance = ApiProvider.internal();
  ApiProvider.internal();
  factory ApiProvider() => _instance;

  final _defaultHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String url, {Map<String, String>? header}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.encodeFull(url),
          headers: header ?? _defaultHeader);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, {body, Map<String, String>? header}) async {
    var responseJson;
    try {
      final response = await http.put(Uri.encodeFull(url),
          headers: header ?? _defaultHeader, body: json.encode(body));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {body, Map<String, String>? header}) async {
    var responseJson;
    try {
      final response = await http.post(Uri.encodeFull(url),
          headers: header ?? _defaultHeader, body: json.encode(body));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getWithDio(String url, {Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await Dio().get(url,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: headers,
          ));
      responseJson = _dioResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithDio(String url,
      {body, Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await Dio().post(url,
          data: body,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: headers,
          ));
      responseJson = _dioResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> putWithDio(String url,
      {body, Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await Dio().put(url,
          data: body,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: headers,
          ));
      responseJson = _dioResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 200, 'response': responseJson};
      case 422:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 422, 'response': responseJson};

      case 400:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 400, 'response': responseJson};

      case 401:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 401, 'response': responseJson};
      case 424:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 424, 'response': responseJson};
      case 405:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 405, 'response': responseJson};
      // case 403:
      //   throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _dioResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        print(responseJson);
        return {'status_code': 200, 'response': responseJson};
      case 400:
        var responseJson = response.data;
        print(responseJson);
        return {'status_code': 400, 'response': responseJson};
      case 405:
        var responseJson = response.data;
        print(responseJson);
        return {'status_code': 405, 'response': responseJson};
      case 422:
        var responseJson = response.data;
        print(responseJson);
        return {'status_code': 422, 'response': responseJson};
      case 201:
        var responseJson = response.data;
        print(responseJson);
        return {'status_code': 201, 'response': responseJson};
      case 401:
      case 403:
        throw UnauthorisedException(response.data);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
