import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utild/routes.dart';
import 'package:flutter_mvvm/utild/routes_name.dart';
import 'package:flutter_mvvm/view/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteName.login,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
