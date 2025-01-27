import 'package:flutter/material.dart';
import 'package:gevoul/screens/home/home_screen.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gevoul Immobilier',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: kParagraphFont.fontFamily, bodyColor: kTextColor),
        useMaterial3: true,
      ),
      home:HomeScreen()
    );
  }
}
