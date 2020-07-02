import 'package:cpui/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class BaseApiServiceProvider {
  final String _baseUrl = "http://localhost:8080/api";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map payload) async {
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: jsonEncode(payload), headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
