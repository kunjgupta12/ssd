import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:providerr/responsive/reesponsive.dart';
import 'package:providerr/screens/create_room.dart';
import 'package:providerr/screens/jaoin_screen.dart';
import 'package:providerr/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routennMAE = '/main-menu';
  const MainMenuScreen({super.key});
  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                onTap: () => createRoom(context), text: 'Create Room '),
            SizedBox(
              height: 20,
            ),
            CustomButton(onTap: () => joinRoom(context), text: 'Join Room ')
          ],
        ),
      ),
    );
  }
}
