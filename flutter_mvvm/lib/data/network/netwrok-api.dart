import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/app_exceptions.dart';
import 'package:flutter_mvvm/data/network/base_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiservice extends BaseApi {
  @override
  Future getGetResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));
    } on SocketException {
      throw FetchDataException('No Internet');
    }
    // TODO: implement getGetResponse
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await post(Uri.parse(url), body: data).timeout(Duration(seconds: 20));
    } on SocketException {
      throw FetchDataException('No internet');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'EWrror occured while communicating with server ' +
                'with status code ' +
                response.statusCode.toString());
    }
  }
}
