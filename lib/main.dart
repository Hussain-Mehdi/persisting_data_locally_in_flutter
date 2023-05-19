import 'package:flutter/material.dart';

import 'screens/setting_screen.dart';

void main() {
  runApp(const SettingScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GlobeApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SettingScreen());
  }
}
