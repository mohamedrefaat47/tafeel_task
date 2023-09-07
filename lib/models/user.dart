class UserResponse {
  UserResponse(
      {required this.page,
      required this.perPage,
      required this.total,
      required this.totalPages,
      required this.data});
  late final int page;
  late final int perPage;
  late final int total;
  late final int totalPages;
  late final List<User> data;

  UserResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    data = List.from(json['data']).map((e) => User.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['per_page'] = perPage;
    _data['total'] = total;
    _data['total_pages'] = totalPages;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
  late final int id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String avatar;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['avatar'] = avatar;
    return _data;
  }
}
