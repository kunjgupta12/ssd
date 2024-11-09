import 'package:ecommerce/logic/cubit/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit(ProductLoadingState(state.products));
    try {
      final product = await _productRepository.fetchproduct();
      emit(ProductLoadedState(product));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }
}
