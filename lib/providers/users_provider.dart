import 'package:flutter/material.dart';
import 'package:tafeel_task/models/user.dart';
import 'package:tafeel_task/networking/api_provider.dart';
import 'package:tafeel_task/utils/urls.dart';

class UsersProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  int _currentPageHome = 1;

  int get currentPageHome => _currentPageHome;

  void setCurrentPageHome(int value, {bool notifyListener = true}) {
    _currentPageHome = value;
    if (notifyListener) notifyListeners();
  }

  int _noOfPagesHome = 1;

  int get noOfPagesHome => _noOfPagesHome;

  void setNoOfPagesHome(int value) {
    _noOfPagesHome = value;
    notifyListeners();
  }

  List<User> _usersList = [];

  List<User> get usersList => _usersList;

  Future<List<User>> getUsersList() async {
    final results = await _apiProvider.get("${Urls.USERS_URL}$currentPageHome");

    if (results['status_code'] == 200) {
      Iterable iterable = results['response']['data'];

      _usersList.addAll(iterable.map((model) => User.fromJson(model)).toList());
      _noOfPagesHome = results['response']['total_pages'];
    } else {
      throw Exception('Failed to load Users');
    }
    notifyListeners();

    return _usersList;
  }

  int? _userSelectedId;

  int? get userSelectedId => _userSelectedId;

  void setUserSelectedId(int value) {
    _userSelectedId = value;
  }

  User? _userSelected;

  User? get userSelected => _userSelected;

  Future<User?> getUserDetails() async {
    final results =
        await _apiProvider.get("${Urls.USER_DETAILS_URL}$_userSelectedId");

    if (results['status_code'] == 200) {
      _userSelected = User.fromJson(results['response']['data']);
    } else {
      throw Exception('Failed to User details');
    }

    return _userSelected;
  }
}
