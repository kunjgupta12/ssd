import 'package:ecommerce/data/models/product/product_model.dart';

abstract class CategoryProductState {
  final List<ProductModel> products;
  CategoryProductState(this.products);
}

class CategorProductInitialState extends CategoryProductState {
  CategorProductInitialState() : super([]);
}

class CategoryProductLoadingState extends CategoryProductState {
  CategoryProductLoadingState(super.products);
}

class CategoryProductLoadedState extends CategoryProductState {
  CategoryProductLoadedState(super.products);
}

class CategoryProductErrorState extends CategoryProductState {
  final String message;
  CategoryProductErrorState(super.products,this.message);
}
