import 'package:flutter/material.dart';
import 'package:tafeel_task/models/user.dart';
import 'package:tafeel_task/screens/user_details_screen/widgets/body.dart';
import 'package:tafeel_task/theme/styles.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;
  const UserDetailsScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Body(user),
    );
  }
}
