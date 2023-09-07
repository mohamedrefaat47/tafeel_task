import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String message;

  const NoData({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.not_interested, size: height * 0.12, color: Colors.purple),
        Container(
          margin: EdgeInsets.only(top: height * 0.02),
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
      ],
    ));
  }
}
