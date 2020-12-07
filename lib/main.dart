import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/AppColors.dart';
import 'package:flutter_app/main_screen.dart';
import 'package:flutter_app/view/login_screen.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: AppColors.BACKGROUND,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                      color: AppColors.COLOR_8CD6FF,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          "images/suitcase.svg",
                          height: 150,
                          width: 150,
                          allowDrawingOutsideViewBox: true,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "My portfel".toUpperCase(),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Инвесторы ждут вас. Предлагайте свои проекты и создайте огромную компанию"
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset("images/people_splash.svg"))
          ],
        ));
  }
}
