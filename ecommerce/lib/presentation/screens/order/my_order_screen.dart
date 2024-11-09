import 'package:ecommerce/logic/cubit/order_cubit/order_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/order_cubit/order_state.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});
  static const routeName = 'my_orders';
  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: SafeArea(
          child: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
        if (state is OrderLoadingState && state.orders.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is OrderErrorState && state.orders.isEmpty) {
          return Center(child: Text(state.message));
        }
        return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return Column(
                children: [
                  Text("${order.sId}"),
                  Text('Order Placed on:${order.createdOn}')
                ],
              );
            });
      })),
    );
  }
}
