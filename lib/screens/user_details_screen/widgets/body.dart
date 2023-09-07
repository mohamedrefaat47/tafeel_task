import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tafeel_task/models/user.dart';
import 'package:tafeel_task/providers/users_provider.dart';
import 'package:tafeel_task/theme/styles.dart';
import 'package:tafeel_task/utils/custom_widgets/connectivity/network_indicator.dart';
import 'package:tafeel_task/utils/custom_widgets/custom_appbar/custom_appbar.dart';
import 'package:tafeel_task/utils/custom_widgets/no_data.dart';
import 'package:tafeel_task/utils/helpers/app_helpers.dart';

class Body extends StatefulWidget {
  final User user;
  const Body(this.user, {super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double _width = 0, _height = 0;
  late Future<User?> _userDetails;
  bool _initialRun = true;
  late UsersProvider _usersProvider;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_initialRun) {
      _usersProvider = Provider.of<UsersProvider>(context, listen: false);

      _usersProvider.setUserSelectedId(widget.user.id);

      _userDetails = _usersProvider.getUserDetails();

      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height - 80;
    return NetworkIndicator(
      child: Scaffold(
          appBar: CustomAppbar(
            title: widget.user.firstName + widget.user.lastName,
            hasBackBtn: true,
          ),
          body: FutureBuilder<User?>(
              future: _userDetails,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: SpinKitFadingCircle(color: Styles.primaryColor),
                    );
                  case ConnectionState.active:
                    return const Text('');
                  case ConnectionState.waiting:
                    return Center(
                      child: SpinKitFadingCircle(color: Styles.primaryColor),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.data != null) {
                      return Container(
                        width: _width,
                        height: _height,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: _height / 20,
                            ),
                            Center(
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage:
                                    NetworkImage(snapshot.data!.avatar),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(
                              height: _height / 30,
                            ),
                            Center(
                              child: Text(
                                snapshot.data!.firstName +
                                    snapshot.data!.lastName,
                                style: const TextStyle(
                                    fontFamily: "Cairo",
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: _height / 20,
                            ),
                            AppHelpers.buildRowItem(
                                title: 'id',
                                value: snapshot.data!.id.toString(),
                                isDetailsPage: true),
                            AppHelpers.buildRowItem(
                                title: 'First name',
                                value: snapshot.data!.firstName,
                                isDetailsPage: true),
                            AppHelpers.buildRowItem(
                                title: 'Last name',
                                value: snapshot.data!.lastName,
                                isDetailsPage: true),
                            AppHelpers.buildRowItem(
                                title: 'Email',
                                value: snapshot.data!.email,
                                isDetailsPage: true),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: NoData(
                          message: "No User",
                        ),
                      );
                    }
                }
              })),
    );
  }
}
