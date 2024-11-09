import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});
  static const routeName = 'order_placed';
  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(CupertinoIcons.cube_box_fill), Text('Oredr Placed')],
        ),
      ),
    );
  }
}
