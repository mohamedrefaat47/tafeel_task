import 'package:flutter/material.dart';
import 'package:tafeel_task/theme/styles.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  const PageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Styles.backgroundColor,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: child,
          ),
        ));
  }
}
