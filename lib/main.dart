import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:movies_app/shared/styles/mytheme.dart';
import 'package:movies_app/ui/screens/home_main_screen/home_main_screen.dart';

import 'ui/screens/Home_fragment/movie_details.dart';
import 'ui/screens/browse_fragment/browse_results.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeMainScreen.routeName:(context) => HomeMainScreen(),
        BrowseResults.routeName : (context)=>BrowseResults(),
        MovieDetails.routeName : (context) => MovieDetails(),

      },
      title: 'Movies',
      initialRoute: HomeMainScreen.routeName,
      theme: MyTheme.Light,
      themeMode: ThemeMode.light,
    );
  }
}

