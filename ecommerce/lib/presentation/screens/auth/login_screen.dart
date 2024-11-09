import 'package:ecommerce/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce/presentation/widgets/primary_botton.dart';
import 'package:ecommerce/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../../logic/cubit/user_cubit/user_state.dart';
import '../../widgets/gap_widgets.dart';
import '../../widgets/link_button.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: provider.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                (provider.error != ''
                    ? Text(
                        provider.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox()),
                PrimaryTextField(
                  labelText: 'Email Address',
                  controller: provider.emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address is required!";
                    }
                    if (!EmailValidator.validate(value.trim())) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                PrimaryTextField(
                  labelText: 'Password',
                  controller: provider.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required!";
                    }
                    return null;
                  },
                ),
                const GapWidget(),
                PrimaryButton(
                  text: (provider.isLoading) ? '...' : 'Log In',
                  onPressed: provider.login,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyles.body2),
                    const GapWidget(),
                    LinkButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        text: "Sign Up")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
