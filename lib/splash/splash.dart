import 'dart:async';

import 'package:flutter/material.dart';

const String LoggedInKey = 'LoggedIn';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final size = query.size;
    final itemWidth = size.width*0.8;
    final itemHeight = itemWidth * (size.width / size.height);
    return Scaffold(
      body: SafeArea(
        child: Stack(
            children:[
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/sincerely-logo.png',
                    width: itemWidth,height: itemHeight,),
                ),
              ),
            ]
        ),
      ),
    );
  }

  @override
  void initState() {
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(
        context,
        '/auth'
      );
    });
    super.initState();
  }
}