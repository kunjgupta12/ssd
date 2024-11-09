import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr/provider/romm_data_provider.dart';
import 'package:providerr/resources/socket_methods.dart';
import 'package:providerr/views/scoreboard.dart';
import 'package:providerr/views/waiting_lobby.dart';

import '../views/tictactoae_board.dart';

class GmaeScreen extends StatefulWidget {
  static String routeName = '/game';
  const GmaeScreen({super.key});

  @override
  State<GmaeScreen> createState() => _GmaeScreenState();
}

class _GmaeScreenState extends State<GmaeScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<RommDattaProvider>(context).player1.nickname.toString());
    print(Provider.of<RommDattaProvider>(context).player2.nickname.toString());
    RommDattaProvider roomdataprovider =
        Provider.of<RommDattaProvider>(context);

    return Scaffold(
        body: roomdataprovider.roomData['isJoin']
            ? const Witinhlobby()
            : SafeArea(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ScroreBoard(),
                  const TicTacToeBoard(),
                  Text(
                      '${roomdataprovider.roomData['turn']['nickname']}\'s turn'),
                ],
              )));
  }
}
