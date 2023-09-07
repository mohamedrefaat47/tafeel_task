import 'package:flutter/material.dart';
import 'package:tafeel_task/theme/styles.dart';

class AppHelpers {
  static Widget buildRowItem(
      {required String title,
      required String value,
      bool isDetailsPage = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: isDetailsPage
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: "Cairo",
                fontSize: isDetailsPage ? 14 : 12,
                color: Styles.onSecondaryColor,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            width: 20,
            child: Text(":"),
          ),
          Text(
            value,
            style: TextStyle(
                fontFamily: "Cairo",
                fontSize: isDetailsPage ? 15 : 13,
                color: Styles.black,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
