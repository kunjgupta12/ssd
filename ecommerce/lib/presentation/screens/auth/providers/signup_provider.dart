import 'dart:async';

import 'package:ecommerce/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/user_cubit/user_cubit.dart';

class SignUpProvider with ChangeNotifier {
  final BuildContext context;

  bool isLoading = false;
  String error = '  ';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  SignUpProvider(this.context) {
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

  void createAccount() async {
    if (!formKey.currentState!.validate()) return;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    BlocProvider.of<UserCubit>(context)
        .createAccount(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}