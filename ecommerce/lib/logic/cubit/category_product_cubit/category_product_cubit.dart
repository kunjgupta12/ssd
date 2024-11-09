import 'dart:math';

import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/data/repository/product_repository.dart';
import 'package:ecommerce/logic/cubit/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategorProductInitialState()) {
    _initialize();
  }
  final _productReposoitory = ProductRepository();

  void _initialize() async {
    emit(CategoryProductLoadingState(state.products));
    try {
      final products =
          await _productReposoitory.fetchproductbycategories(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(CategoryProductErrorState(state.products!, ex.toString()));
    }
  }
}
