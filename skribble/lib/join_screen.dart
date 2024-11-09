import 'package:flutter/material.dart';
import 'package:skribble/paint_screen.dart';
import 'package:skribble/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  void joinRoom() {
    if (_nameController.text.isNotEmpty && _roomController.text.isNotEmpty) {
      Map<String, String> data = {
        "nickname": _nameController.text,
        "name": _roomController.text
      };

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PaintScreen(data: data, screenFrom: 'joinRoom')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Join Room",
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
                controller: _nameController, hintText: "Enter Your Name"),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
                controller: _roomController, hintText: "Enter Room Id"),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: joinRoom,
            child: Text(
              "Join",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                textStyle:
                    MaterialStateProperty.all(TextStyle(color: Colors.white)),
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width / 2.5, 50))),
          ),
        ],
      ),
    );
  }
}
