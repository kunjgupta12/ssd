import 'dart:async';

import 'package:ecommerce/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/user_cubit/user_cubit.dart';

class LoginProvider with ChangeNotifier {
  final BuildContext context;

  bool isLoading = false;
  String error = '  ';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  LoginProvider(this.context) {
    listenToUserCubit();
  }
  void listenToUserCubit() {
    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userSate) {
      if (userSate is UserLoadingState) {
        isLoading = true;
        error = '';
        notifyListeners();
      } else if (userSate is UserErrorState) {
        isLoading = false;
        error = userSate.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = '';
        notifyListeners();
      }
    });
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    BlocProvider.of<UserCubit>(context)
        .signIn(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
