import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecommerce/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce/presentation/screens/home/home_screen.dart';
import 'package:ecommerce/presentation/screens/order/my_order_screen.dart';
import 'package:ecommerce/presentation/screens/order/order_detail_screen.dart';
import 'package:ecommerce/presentation/screens/order/order_placed_screen.dart';
import 'package:ecommerce/presentation/screens/product/category_product_screen.dart';
import 'package:ecommerce/presentation/screens/product/product_detail.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce/presentation/screens/user/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../data/models/product/product_model.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/cart/car_screen.dart';
import '../presentation/screens/order/provider/oder_details_provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => LoginProvider(context),
              child: const LoginScreen()),
        );
      case SignUpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => SignUpProvider(context),
              child: const SignUpScreen()),
        );
      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());
      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const EditProfileScreen());

      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const CartScreen());
      case CategoryProductScreen.RouteName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      CategoryProductCubit(settings.arguments as CategoryModel),
                  child: const CategoryProductScreen(),
                ));

      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case OrderDetailScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => OrderDetailProvider(),
                child: const OrderDetailScreen()));
      case productdetailScreen.Routename:
        return CupertinoPageRoute(
            builder: (context) => productdetailScreen(
                  productModel: settings.arguments as ProductModel,
                ));
      case Order.routeName:
        return CupertinoPageRoute(builder: (context) => Order());
      case MyOrder.routeName:
        return CupertinoPageRoute(builder: (context) => MyOrder());

      default:
        return null;
    }
  }
}
