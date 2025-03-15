import 'package:flutter/material.dart';

import 'app/routes/app_pages.dart';
import 'base/color_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: backGroundColor, // Global background color
          primaryColor: greenColor,
        buttonTheme: ButtonThemeData(
          buttonColor: greenColor, // Default button color
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: AppPages.routes,
    );
  }
}
