import 'package:ecommerce/logic/cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce/presentation/screens/product/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/category_cubit/category_state.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
      if (state is CategoryLoadingState && state.categories.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CategoryErrorState && state.categories.isEmpty) {
        return Center(
          child: Text(state.message.toString()),
        );
      }
      return ListView.builder(
        itemCount: state.categories.length,
        itemBuilder: (context, index) {
          final categories = state.categories[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, CategoryProductScreen.RouteName,
                  arguments: categories);
            },
            leading: const Icon(Icons.category),
            title: Text('${categories.title}'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        },
      );
    }));
  }
}
