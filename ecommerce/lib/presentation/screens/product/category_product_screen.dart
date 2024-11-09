import 'package:ecommerce/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce/logic/cubit/category_product_cubit/category_product_state.dart';
import 'package:ecommerce/presentation/widgets/product_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/category_cubit/category_state.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});
  static const RouteName = 'categoryproductScreen';

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoryProductCubit>(context);
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
        builder: (context, state) {
          if (state is CategoryLoadingState && state.products.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CategoryLoadedState && state.products.isEmpty) {
            return Center(
              child: Text('No product found!'),
            );
          }
          if (state is CategoryProductErrorState && state.products.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }
          return ProductListView(products: state.products);
        },
      )),
      appBar: AppBar(
        title: Text('${cubit.category.title}'),
      ),
    );
  }
}
