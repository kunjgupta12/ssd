import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String BASE_URL = 'http://192.168.29.134:5000/api';

//  "https://ecommerce-backend-qjee.onrender.com/api";
const Map<String, dynamic> DEFAULT_HEADER = {
  'Content-Type': 'application/json'
};

class Api {
  final Dio _dio = Dio();
  Api() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADER;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ));
  }
  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;
  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
        success: data['success'],
        data: data['data'],
        message: data['message'] ?? 'Unexpected Error');
  }
}
