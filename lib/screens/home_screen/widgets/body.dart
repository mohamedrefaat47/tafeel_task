import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tafeel_task/models/user.dart';
import 'package:tafeel_task/providers/users_provider.dart';
import 'package:tafeel_task/screens/home_screen/widgets/user_widget.dart';
import 'package:tafeel_task/theme/styles.dart';
import 'package:tafeel_task/utils/custom_widgets/connectivity/network_indicator.dart';
import 'package:tafeel_task/utils/custom_widgets/custom_appbar/custom_appbar.dart';
import 'package:tafeel_task/utils/custom_widgets/no_data.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double _height = 0, _width = 0;
  late Future<List<User>> _usersList;
  bool _initialRun = true;
  late UsersProvider _usersProvider;
  final ScrollController _scrollListViewController = ScrollController();
  final ValueNotifier<bool> usersLoading = ValueNotifier(false);

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_initialRun) {
      _usersProvider = Provider.of<UsersProvider>(context, listen: false);

      _usersProvider.setCurrentPageHome(1, notifyListener: false);

      _usersList = _usersProvider.getUsersList();

      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height - 80;
    _width = MediaQuery.of(context).size.width;

    return NetworkIndicator(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppbar(title: "Home"),
          body: SingleChildScrollView(
            child: SizedBox(
              height: _height,
              width: _width,
              child: Stack(children: [
                FutureBuilder<List<User>>(
                    future: _usersList,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child:
                                SpinKitFadingCircle(color: Styles.primaryColor),
                          );
                        case ConnectionState.active:
                          return const Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child:
                                SpinKitFadingCircle(color: Styles.primaryColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.data!.isNotEmpty) {
                            return NotificationListener<ScrollNotification>(
                                onNotification:
                                    (ScrollNotification scrollInfo) {
                              if (scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent &&
                                  _usersProvider.currentPageHome <
                                      _usersProvider.noOfPagesHome) {
                                _usersProvider.setCurrentPageHome(
                                    _usersProvider.currentPageHome + 1);
                                usersLoading.value = true;
                                _usersList = _usersProvider.getUsersList();
                                usersLoading.value = false;
                              }
                              return true;
                            }, child: Consumer<UsersProvider>(
                              builder: (context, userProv, child) {
                                return ListView.builder(
                                  controller: _scrollListViewController,
                                  itemCount: userProv.usersList.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: 120,
                                      child: UserWidget(
                                          index, userProv.usersList[index]),
                                    );
                                  },
                                );
                              },
                            ));
                          } else {
                            return const Center(
                              child: NoData(
                                message: "No Users",
                              ),
                            );
                          }
                      }
                    }),
                ValueListenableBuilder<bool>(
                  valueListenable: usersLoading,
                  builder: (_, loading, __) {
                    return Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: loading
                          ? Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: SpinKitFadingCircle(
                                    color: Styles.primaryColor),
                              ),
                            )
                          : Container(),
                    ));
                  },
                )
              ]),
            ),
          )),
    );
  }
}
