import 'package:flutter/material.dart';
import 'package:socket_chat/chatTitle.dart';
import 'package:socket_chat/chat_model.dart';
import 'package:socket_chat/global.dart';
import 'package:socket_chat/loginscareen.dart';
import 'package:socket_chat/user.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});
  static const String ROUTE_ID = 'chat_screen';

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<ChatMessageModel>? _chatMessages;
  User? _toChatUser;
  UserOnlineStatus? _userOnlineStatus;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _toChatUser = G.toChatUser;
    _userOnlineStatus = UserOnlineStatus.connecting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChatTitle(userOnlineStatus: _userOnlineStatus!),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[_bottomChatArea()],
        ),
      ),
    );
  }
/*
  _chatList() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          cacheExtent: 100,
          //controller: _chatLVController,
          reverse: false,
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          itemCount: null == _chatMessages ? 0 : _chatMessages.length,
          itemBuilder: (context, index) {
            ChatMessageModel chatMessage = _chatMessages[index];
            return chatMessage;
            /*  return _chatBubble(
              chatMessage,
            );*/
          },
        ),
      ),
    );
  }*/

  _bottomChatArea() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          _chatTextArea(),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              // _sendButtonTap();
            },
          ),
        ],
      ),
    );
  }

  _chatTextArea() {
    return Expanded(
      child: TextField(
        //   controller: _chatTfController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.0,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(10.0),
          hintText: 'Type message...',
        ),
      ),
    );
  }
}
