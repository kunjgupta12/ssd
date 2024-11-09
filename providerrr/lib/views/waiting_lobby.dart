import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr/provider/romm_data_provider.dart';
import 'package:providerr/widgets/custom_textfiled.dart';

class Witinhlobby extends StatefulWidget {
  const Witinhlobby({super.key});

  @override
  State<Witinhlobby> createState() => _WitinhlobbyState();
}

class _WitinhlobbyState extends State<Witinhlobby> {
  TextEditingController? roomIdController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomIdController = TextEditingController(
        text: Provider.of<RommDattaProvider>(context, listen: false)
            .roomData['_id']);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    roomIdController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Waiting for other to join..'),
        SizedBox(
          height: 20,
        ),
        CustomTextField(
          controller: roomIdController!,
          hintText: '',
          isReadOnly: true,
        )
      ],
    );
  }
}
