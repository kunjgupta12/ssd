import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr/provider/romm_data_provider.dart';

class ScroreBoard extends StatefulWidget {
  const ScroreBoard({super.key});

  @override
  State<ScroreBoard> createState() => _ScroreBoardState();
}

class _ScroreBoardState extends State<ScroreBoard> {
  @override
  Widget build(BuildContext context) {
    RommDattaProvider rommDattaProvider =
        Provider.of<RommDattaProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                rommDattaProvider.player1.nickname,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                rommDattaProvider.player1.points.toString(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                rommDattaProvider.player2.nickname,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                rommDattaProvider.player2.points.toString(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
