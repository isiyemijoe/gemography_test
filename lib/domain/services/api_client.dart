import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemography_test/presentation/utils/uihelper.dart';
import 'package:http/http.dart' as http;
import 'package:validators/sanitizers.dart';

class ApiClient {
  final http.Client client;
  String baseUrl =
      "https://api.github.com/search/repositories?q=created:%3E2017-10-22&sort=stars&order=desc";
  final bool showError;

  ApiClient({
    http.Client client,
    this.showError: true,
  }) : client = client ?? http.Client();

  Future<dynamic> get({String url = ""}) async {
    debugPrint("Url: $url");

    var responseJson;
    try {
      print("trying to run");
      final response = await client.get(Uri.parse(baseUrl + url), headers: {
        'Content-type': 'application/json',
      });
      print(response.body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print("Erro roccured");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {Map<String, dynamic> data}) async {
    var responseJson;
    try {
      final response = await client.post(Uri.parse(baseUrl + url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: json.encode(data));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, {Map<String, dynamic> data}) async {
    var responseJson;
    try {
      final response = await client.put(Uri.parse(baseUrl + url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: json.encode(data));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    try {
      return _getResponse(response);
    } on AppException catch (e) {
      if (showError) {
        UIhelper.error(e._message);
      }
      throw e;
    }
  }

  dynamic _getResponse(http.Response response) {
    int code = response.statusCode;
    if (response.body.startsWith('{"status":"error"')) {
      // handle v1 fake 200 errors
      if (response.statusCode != 401) code = 400;
    }
    switch (code) {
      case 400:
        print('badddd');
        throw BadRequestException(
            json.decode(response.body.toString())['message']);
      case 401:
        throw InvalidTokenException(json.decode(response.body)['message']);
      case 403:
        throw UnauthorisedException(json.decode(response.body)['message']);
      case 500:
      default:
        if (!isResponseOk(response.statusCode)) {
          throw FetchDataException('\n StatusCode : ${response.statusCode}.'
              '\n Response: ${response.body.toString()}');
        }
        var responseJson = json.decode(response.body.toString());
        return responseJson;
    }
  }

  bool isResponseOk(int statusCode) {
    return statusCode >= 200 && statusCode <= 299;
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidTokenException extends AppException {
  InvalidTokenException([message]) : super(message, "Invalid Token: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
