import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/image_constant.dart';
import '../../../logic/cubit/user_cubit/user_cubit.dart';
import '../../../logic/cubit/user_cubit/user_state.dart';
import '../../widgets/custom_image_view copy.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goToNextScreen() {
    UserState userState = BlocProvider.of<UserCubit>(context).state;
    if (userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else if (userState is UserLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else if (userState is UserErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      goToNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          goToNextScreen();
        },
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgFrameFive,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle4284,
                    height: 156,
                    width: 388,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
