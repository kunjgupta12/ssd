import 'package:flutter/material.dart';
import 'package:skribble/create_room_screen.dart';
import 'package:skribble/join_screen.dart';

class HomeScareen extends StatefulWidget {
  const HomeScareen({super.key});

  @override
  State<HomeScareen> createState() => _HomeScareenState();
}

class _HomeScareenState extends State<HomeScareen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Create /Join the room tom play",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CreateRoomScreen()),
                        ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white)),
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width / 2.5, 50))),
                    child: const Text(
                      "Create ",
                      style: TextStyle(fontSize: 16),
                    )),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => JoinRoomScreen())),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white)),
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width / 2.5, 50))),
                    child: Text(
                      "Join ",
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ]),
    );
  }
}
