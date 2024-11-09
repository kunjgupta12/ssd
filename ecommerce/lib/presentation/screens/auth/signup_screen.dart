import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_widgets.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_botton.dart';
import '../../widgets/primary_textfield.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              (provider.error != ''
                  ? Text(
                      provider.error,
                      style:const TextStyle(color: Colors.red),
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
                controller: provider.cpasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Confirm your Password !";
                  }
                  if (value.trim() != provider.passwordController.text.trim()) {
                    return 'Passwords do not match ';
                  }
                  return null;
                },
              ),
              const GapWidget(),
              const SizedBox(
                height: 16,
              ),
              PrimaryTextField(
                labelText: 'Confirm Password',
                controller: provider.passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is required!";
                  }
                  return null;
                },
              ),
              PrimaryButton(
                text: (provider.isLoading) ? '...' : 'Create Account',
                onPressed: provider.createAccount,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyles.body2),
                  const GapWidget(),
                  LinkButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      text: "Login ")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
