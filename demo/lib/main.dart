import 'package:demo/auth_provider.dart';
import 'package:demo/login.dart';
import 'package:demo/theme.dart';
import 'package:demo/theme_provider.dart';
import 'package:demo/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final Theme = Provider.of<themechanger>(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => themechanger(),
          ),
          ChangeNotifierProvider(create: (_) => Authprovider())
        ],
        child: Builder(builder: (BuildContext context) {
          final themechangee = Provider.of<themechanger>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.yellow,
              primaryColor: Colors.purple,
            ),
            // darkTheme: ThemeData(brightness: Brightness.dark),
            home: loginScreen(),
          );
        }));
  }
}
