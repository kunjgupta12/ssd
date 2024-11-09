import 'package:chat_app/controller/chart_controller.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgInputController = TextEditingController();
  late IO.Socket socket;
  ChatController chatController = ChatController();
  @override
  void initState() {
    socket = IO.io(
        'http://localhost:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    setUpSoxcketListener();
    super.initState();
    socket.connect();
    print(socket.ids);
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Obx(
                () => Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Connected User ${chatController.connectedUser}'),
                ),
              )),
              Expanded(
                  flex: 9,
                  child: Obx(
                    () => ListView.builder(
                        itemCount: chatController.chatMessages.length,
                        itemBuilder: (context, index) {
                          var currentItem = chatController.chatMessages[index];
                          return MessageItem(
                            sentByMe: currentItem.sentByMe == socket.id,
                            message: currentItem.message,
                          );
                        }),
                  )),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.amber,
                  controller: msgInputController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: IconButton(
                            onPressed: () {
                              sendMessage(msgInputController.text);

                              msgInputController.text = '';
                              print(socket.id);
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                      )),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage(String text) {
    var messageJson = {'message': text, 'sentByMe': socket.ids};
    socket.emit('message', messageJson);
    chatController.chatMessages.add(Message.fromJson(messageJson));
    print(socket.auth);
  }

  void setUpSoxcketListener() {
    socket.on('message-receive', (data) {
      print(data);
      chatController.chatMessages.add(Message.fromJson(data));
    });
    socket.on('connected-user', (data) {
      print(data);
      chatController.connectedUser.value = data;
    });
  }
}

class MessageItem extends StatelessWidget {
  final bool sentByMe;
  final String message;
  MessageItem({required this.message, required this.sentByMe, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: sentByMe ? Colors.purple : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: sentByMe ? Colors.white : Colors.purple, fontSize: 18),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '1.10',
              style: TextStyle(
                  color: sentByMe ? Colors.white : Colors.purple, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
