import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/data/repository/category_reporitory.dart';
import 'package:ecommerce/logic/cubit/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()) {
    _intialize();
  }
  final _categoryrepository = CategoryRepository();

  void _intialize() async {
    emit(CategoryLoadingState(state.categories));
    try {
      List<CategoryModel> categories =
          await _categoryrepository.fetchCategory();

      emit(CategoryLoadedState(categories));
    } catch (ex) {
      emit(CategoryErrorState(ex.toString(), state.categories));
    }
  }
}
