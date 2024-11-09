import 'package:flutter/material.dart';
import 'User.dart';

enum UserOnlineStatus { connecting, online, not_online }

class ChatTitle extends StatelessWidget {
  //
  const ChatTitle({
    Key? key,
    this.chatUser,
    required this.userOnlineStatus,
  }) : super(key: key);

  final User? chatUser;
  final UserOnlineStatus userOnlineStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(chatUser!.name.toString()),
          Text(
            _getStatusText(),
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }

  _getStatusText() {
    if (userOnlineStatus == UserOnlineStatus.connecting) {
      return 'connecting...';
    }
    if (userOnlineStatus == UserOnlineStatus.online) {
      return 'online';
    }
    if (userOnlineStatus == UserOnlineStatus.not_online) {
      return 'not online';
    }
  }
}
