import 'package:flutter/material.dart';
import 'package:tafeel_task/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  double _width = 0;

  Future<void> navigateToLoginPage() async {
    await Future.delayed(const Duration(
      milliseconds: 2000,
    )).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/tafeel_logo.png',
        fit: BoxFit.fitWidth,
        height: _width / 1.5,
        width: _width / 1.5,
      ),
    ));
  }
}
