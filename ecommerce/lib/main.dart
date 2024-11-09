import 'dart:developer';

import 'package:ecommerce/core/routes.dart';
import 'package:ecommerce/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce/logic/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/logic/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(
            create: (context) =>
                CartCubit(BlocProvider.of<UserCubit>(context))),
        BlocProvider(
            create: (context) => OrderCubit(
                  BlocProvider.of<UserCubit>(context),
                  BlocProvider.of<CartCubit>(context),
                ))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log('Created $bloc');
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("change in $bloc :$change");
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed:$bloc");
    super.onClose(bloc);
  }
}
