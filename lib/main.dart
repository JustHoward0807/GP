import 'package:GP/home/newHome.dart';
import 'package:GP/styles/myColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp2());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          seconds: 3,
          backgroundColor: mainbgcolor,
          image: Image.asset('assets/Icons/logo.png'),
          loaderColor: Colors.black,
          loadingText: Text('載入中'),
          photoSize: 150.0,
          navigateAfterSeconds: MyApp2(),
        ));
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: NewHomePage(),
    );
  }
}
/*"assets/Icons/.DS_Store": ["assets/Icons/.DS_Store"], 
    "assets/.DS_Store": ["assets/.DS_Store", "assets/Icons/.DS_Store"],
    "packages/cupertino_icons/assets/CupertinoIcons.ttf": [
      "packages/cupertino_icons/assets/CupertinoIcons.ttf"
    ], */
