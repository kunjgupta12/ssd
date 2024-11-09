import 'package:demo/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<Authprovider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(hintText: 'mail'),
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(hintText: 'mail'),
            ),
            SizedBox(
              height: 29,
            ),
            InkWell(
              onTap: () {
                authprovider.login(
                    email.text.toString(), password.text.toString());
              },
              child: Container(
                child:
                    authprovider.loading ? Text('Login') : Text('No account'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
