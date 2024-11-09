import 'package:flutter/material.dart';
import 'package:socket_chat/chatScreen.dart';
import 'package:socket_chat/global.dart';
import 'package:socket_chat/loginscareen.dart';
import 'package:socket_chat/user.dart';

class ChatUserScreen extends StatefulWidget {
  const ChatUserScreen({super.key});
  static const String ROUTE_ID = 'chat_user_screen';

  @override
  State<ChatUserScreen> createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  List<User>? _chatUsers;
  @override
  void initState() {
    // TODO: implement initState
    _chatUsers = G.getUsersFor(G.logginUser!);
    super.initState();
  }

  _openLoginScreen(context) async {
    await Navigator.pushReplacementNamed(context, LoginScreen.ROUTE_ID);
  }

  _openXhatScreen(context) async {
    await Navigator.pushNamed(context, Chat.ROUTE_ID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          IconButton(
              onPressed: () {
                _openLoginScreen(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: _chatUsers!.length,
                    itemBuilder: (context, index) {
                      User user = _chatUsers![index];
                      return ListTile(
                          onTap: () {
                            G.toChatUser = user;
                            _openXhatScreen(context);
                          },
                          title: Text(user.name!),
                          subtitle: Text('${user.id} ,${user.email}'));
                    }))
          ],
        ),
      ),
    );
  }
}
