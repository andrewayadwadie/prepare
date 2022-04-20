import 'dart:async';

import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer? _timer;
  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const LoginScreen();
      }));
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(100),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient:
                RadialGradient(colors: [Color(0xff008d36), Color(0xff005133)]),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 20,
            height: MediaQuery.of(context).size.height / 20,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "assets/images/logo.png",
              ),
              fit: BoxFit.contain,
            )),
          ),
        ),
      ),
    );
  }
}
