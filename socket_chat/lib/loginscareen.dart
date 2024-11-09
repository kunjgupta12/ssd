import 'package:flutter/material.dart';
import 'package:socket_chat/chatUserScreen.dart';
import 'package:socket_chat/global.dart';
import 'package:socket_chat/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String ROUTE_ID = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    G.initDummyUser();
    username = TextEditingController();
  }

  TextEditingController? username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lets Chat"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            TextField(
              controller: username,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(20)),
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
                onPressed: () {
                  ///
                  _loginbtnTap();
                },
                child: Text('LOGIN'))
          ],
        ),
      ),
    );
  }

  _loginbtnTap() {
    if (username!.text.isEmpty) {
      return;
    }
    User me = G.dummyUser![0];
    if (username!.text != 'a') {
      me = G.dummyUser![1];
    }
    G.logginUser = me;
    _openchatuserscreen(context);
  }

  _openchatuserscreen(context) async {
    await Navigator.pushReplacementNamed(context, ChatUserScreen.ROUTE_ID);
  }
}
