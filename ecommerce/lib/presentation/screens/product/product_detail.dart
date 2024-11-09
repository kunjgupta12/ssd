import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce/logic/services/formatter.dart';
import 'package:ecommerce/presentation/widgets/gap_widgets.dart';
import 'package:ecommerce/presentation/widgets/primary_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class productdetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const productdetailScreen({super.key, required this.productModel});
  static const Routename = 'productdeatils';
  @override
  State<productdetailScreen> createState() => _productdetailScreenState();
}

class _productdetailScreenState extends State<productdetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.productModel.title}'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.productModel.images!.length,
                slideBuilder: (index) {
                  return CachedNetworkImage(
                      imageUrl: widget.productModel.images![index]);
                },
              )),
          const GapWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.productModel.title}",
                    style: TextStyles.heading3),
                Text(
                  "${Formatter.formatprice(
                    widget.productModel.price!,
                  )}",
                  style: TextStyles.heading2,
                ),
                const GapWidget(
                  size: 10,
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    bool isInCart = BlocProvider.of<CartCubit>(context)
                        .cartContains(widget.productModel);
                    return PrimaryButton(
                      color: (BlocProvider.of<CartCubit>(context)
                              .cartContains(widget.productModel))
                          ? AppColors.textLight
                          : AppColors.accent,
                      text: (BlocProvider.of<CartCubit>(context)
                              .cartContains(widget.productModel))
                          ? 'Product added to cart'
                          : 'Add to Cart',
                      onPressed: () {
                        if (isInCart) {
                          return;
                        }
                        BlocProvider.of<CartCubit>(context)
                            .addToCart(widget.productModel, 1);
                      },
                    );
                  },
                ),
                const GapWidget(
                  size: 10,
                ),
                Text(
                  'Description',
                  style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(widget.productModel.description.toString(),
                    style: TextStyles.body1),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
