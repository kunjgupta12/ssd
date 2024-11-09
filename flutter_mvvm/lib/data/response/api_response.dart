import 'package:flutter_mvvm/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponse(this.status, this.data, this.message);
  ApiResponse.complete() : status = Status.COMPLETE;
  ApiResponse.error() : status = Status.ERROR;

  ApiResponse.loading() : status = Status.LOADING;
  String toString() {
    return 'Status :$status\n Message:$message\n Data:$data';
  }
}
