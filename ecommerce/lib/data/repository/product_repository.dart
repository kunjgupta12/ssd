import 'package:dio/dio.dart';
import 'package:ecommerce/core/api.dart';
import 'package:ecommerce/data/models/product/product_model.dart';

class ProductRepository {
  final _api = Api();

  Future<List<ProductModel>> fetchproduct() async {
    try {
      Response response = await _api.sendRequest.get(
        '/product',
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchproductbycategories(String categoryid) async {
    try {
      Response response = await _api.sendRequest.get(
        '/product/category/$categoryid',
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
