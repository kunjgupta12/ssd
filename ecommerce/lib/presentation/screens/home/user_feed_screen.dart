import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/logic/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce/logic/cubit/product_cubit/product_state.dart';
import 'package:ecommerce/presentation/screens/product/product_detail.dart';
import 'package:ecommerce/presentation/widgets/gap_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/services/formatter.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductErrorState && state.products.isEmpty) {
          return Center(
            child: Text(state.message.toString()),
          );
        }

        return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return CupertinoButton(
                onPressed: () {
                  Navigator.pushNamed(context, productdetailScreen.Routename,
                      arguments: product);
                },
                padding: EdgeInsets.zero,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${product.images?[0]}",
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.title}',
                            style: TextStyles.body1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.description}',
                            style: TextStyles.body2
                                .copyWith(color: AppColors.textLight),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const GapWidget(),
                          Text(
                            '₹ ${Formatter.formatprice(product.price!)}',
                            style: TextStyles.heading3,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
