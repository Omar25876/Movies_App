import 'package:flutter/material.dart';
import 'package:movies_app/shared/styles/mytheme.dart';
import 'package:movies_app/ui/screens/home_main_screen/home_main_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeMainScreen.routeName:(context) => HomeMainScreen(),

      },
      initialRoute: HomeMainScreen.routeName,
      theme: MyTheme.Light,
      themeMode: ThemeMode.light,
    );
  }
}

