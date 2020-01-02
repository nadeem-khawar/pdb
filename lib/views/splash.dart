import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/common/styles.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void navigationToNextPage() {
    Navigator.pushReplacementNamed(context, homeRoute);
  }

  startSplashScreenTimer() async {
    var _duration = Duration(seconds: 2);
    return new Timer(_duration, navigationToNextPage);
  }


  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      color: kDBBackgroundGrey,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.4,
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
