import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce/logic/services/calculation.dart';
import 'package:ecommerce/presentation/screens/order/order_detail_screen.dart';
import 'package:ecommerce/presentation/widgets/cart_list_widgets.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../logic/services/formatter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const routeName = 'cart';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState && state.items.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartErrorState && state.items.isEmpty) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is CartLoadedState && state.items.isEmpty) {
              return const Center(
                child: Text('Cart items will show up here..'),
              );
            }
            return Column(
              children: [
                Expanded(child: CartListView(items: state.items)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' ${state.items.length} items',
                            style: TextStyles.body1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total :${Calculations.cartTotal(state.items)}',
                            style: TextStyles.heading3,
                          )
                        ],
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: CupertinoButton(
                          child: Text('Place Order'),
                          color: AppColors.accent,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(OrderDetailScreen.routeName);
                          },
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
