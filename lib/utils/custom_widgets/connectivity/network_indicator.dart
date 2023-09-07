import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_offline/flutter_offline.dart';
import 'package:tafeel_task/theme/styles.dart';
import 'package:tafeel_task/utils/custom_widgets/custom_appbar/custom_appbar.dart';

class NetworkIndicator extends StatefulWidget {
  final Widget child;

  const NetworkIndicator({super.key, required this.child});
  @override
  NetworkIndicatorState createState() => NetworkIndicatorState();
}

class NetworkIndicatorState extends State<NetworkIndicator> {
  double _height = 0;

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: _height * 0.2,
            ),
            Icon(
              Icons.signal_wifi_off,
              size: _height * 0.25,
              color: Colors.grey[400],
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  "No Internet",
                  style: TextStyle(
                      fontFamily: "cairo",
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                )),
            Container(
                margin: EdgeInsets.only(top: _height * 0.05),
                child: Text(
                  'Check your router',
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400),
                )),
            Container(
                margin: EdgeInsets.only(top: _height * 0.05),
                child: Text(
                  'and reconnect',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400),
                )),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          const appBar = CustomAppbar(
            title: "Tafeel",
            hasBackBtn: false,
          );
          _height = MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top;
          return Scaffold(
            appBar: appBar,
            body: _buildBodyItem(),
          );
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return widget.child;
      },
    );
  }
}
