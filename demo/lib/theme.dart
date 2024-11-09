import 'package:demo/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkTheme extends StatefulWidget {
  const DarkTheme({super.key});

  @override
  State<DarkTheme> createState() => _DarkThemeState();
}

class _DarkThemeState extends State<DarkTheme> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themechanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('sub'),
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
              title: Text('Light Mode'),
              value: ThemeMode.light,
              groupValue: theme.thememode,
              onChanged: theme.setTheme),
          RadioListTile<ThemeMode>(
              title: Text('Dark Mode'),
              value: ThemeMode.dark,
              groupValue: theme.thememode,
              onChanged: theme.setTheme),
          RadioListTile<ThemeMode>(
              title: Text('System Mode'),
              value: ThemeMode.system,
              groupValue: theme.thememode,
              onChanged: theme.setTheme)
        ],
      ),
    );
  }
}
