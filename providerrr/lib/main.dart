import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr/provider/romm_data_provider.dart';
import 'package:providerr/screens/create_room.dart';
import 'package:providerr/screens/game+csreeen.dart';
import 'package:providerr/screens/jaoin_screen.dart';
import 'package:providerr/screens/main_menu_screen.dart';
import 'package:providerr/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RommDattaProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
        routes: {
          JoinRoomScreen.routeName: (context) => JoinRoomScreen(),
          GmaeScreen.routeName: (context) => GmaeScreen(),
          CreateRoomScreen.routeName: (context) => CreateRoomScreen(),
          MainMenuScreen.routennMAE: (context) => const MainMenuScreen()
        },
        initialRoute: MainMenuScreen.routennMAE,
      ),
    );
  }
}
