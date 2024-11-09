import 'dart:developer';

import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:ecommerce/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce/presentation/screens/order/order_placed_screen.dart';
import 'package:ecommerce/presentation/screens/order/provider/oder_details_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../data/models/orders/order_model.dart';
import '../../../logic/cubit/order_cubit/order_cubit.dart';
import '../../../logic/cubit/user_cubit/user_state.dart';
import '../../../logic/services/razorpay.dart';
import '../../widgets/cart_list_widgets.dart';
import '../../widgets/gap_widgets.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_botton.dart';
import '../user/edit_profile_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});
  static const routeName = 'order_detail';
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Order'),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const CircularProgressIndicator();
              }
              if (state is UserLoggedInState) {
                UserModel user = state.userModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.fullName}',
                      style: TextStyles.heading3,
                    ),
                    Text(
                      "Email: ${user.email}",
                      style: TextStyles.body2,
                    ),
                    Text(
                      "Phone: ${user.phoneNumber}",
                      style: TextStyles.body2,
                    ),
                    Text(
                      "Address: ${user.address}, ${user.city}, ${user.state}",
                      style: TextStyles.body2,
                    ),
                    LinkButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, EditProfileScreen.routeName);
                        },
                        text: "Edit Profile"),
                  ],
                );
              }
              if (state is UserErrorState) {
                return Text(state.message);
              }
              return SizedBox();
            },
          ),
          const GapWidget(size: 10),
          Text(
            "Items",
            style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
          ),
          const GapWidget(),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoadingState && state.items.isEmpty) {
                return const CircularProgressIndicator();
              }

              if (state is CartErrorState && state.items.isEmpty) {
                return Text(state.message);
              }
              return CartListView(
                items: state.items,
                shrinkWrap: true,
                noScroll: true,
              );
            },
          ),
          const GapWidget(size: 10),
          Text(
            "Payment",
            style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
          ),
          const GapWidget(),
          Consumer<OrderDetailProvider>(builder: (context, provider, child) {
            return Column(
              children: [
                RadioListTile(
                  value: "pay-on-delivery",
                  groupValue: provider.paymentMethod,
                  contentPadding: EdgeInsets.zero,
                  onChanged: provider.changePaymentMethod,
                  title: const Text("Pay on Delivery"),
                ),
                RadioListTile(
                  value: "pay-now",
                  groupValue: provider.paymentMethod,
                  contentPadding: EdgeInsets.zero,
                  onChanged: provider.changePaymentMethod,
                  title: const Text("Pay Now"),
                ),
              ],
            );
          }),
          const GapWidget(),
          PrimaryButton(
              onPressed: () async {
                OrderModel? newOrder =
                    await BlocProvider.of<OrderCubit>(context).createOrder(
                  items: BlocProvider.of<CartCubit>(context).state.items,
                  paymentMethod:
                      Provider.of<OrderDetailProvider>(context, listen: false)
                          .paymentMethod
                          .toString(),
                );

                if (newOrder == null) return;
                if (newOrder.status == "payment-pending") {
                  await RazorPayServices.checkoutOrder(newOrder,
                      onSuccess: (response) async {
                    newOrder.status = "order-placed";

                    bool success = await BlocProvider.of<OrderCubit>(context)
                        .updateOrder(newOrder,
                            paymentId: response.paymentId,
                            signature: response.signature);

                    if (!success) {
                      log("Can't update the order!");
                      return;
                    }

                    Navigator.popUntil(context, (route) => route.isFirst);

                    Navigator.pushNamed(context, Order.routeName);
                  }, onFailure: (response) {
                    log("Payment Failed!");
                  });
                }

                if (newOrder.status == "order-placed") {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(context, Order.routeName);
                }
              },
              text: "Place Order"),
        ],
      )),
    );
  }
}
