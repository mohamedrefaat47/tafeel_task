import 'package:flutter/material.dart';
import 'package:tafeel_task/screens/home_screen/widgets/body.dart';
import 'package:tafeel_task/theme/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Body(),
    );
  }
}
