import 'package:flutter/material.dart';
import 'package:tafeel_task/models/user.dart';
import 'package:tafeel_task/screens/user_details_screen/user_details_screen.dart';
import 'package:tafeel_task/theme/styles.dart';
import 'package:tafeel_task/utils/helpers/app_helpers.dart';

class UserWidget extends StatelessWidget {
  final int tag;
  final User user;

  UserWidget(this.tag, this.user, {super.key});

  double _width = 0;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserDetailsScreen(user: user)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Styles.grey_300, width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Hero(
            tag: Text('$tag'),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FittedBox(
                    child: Image.network(user.avatar,
                        width: _width / 3,
                        height: _width / 3,
                        fit: BoxFit.fitWidth, loadingBuilder:
                            (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: _width / 3,
                        width: _width / 3,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Styles.primaryColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppHelpers.buildRowItem(
                        title: 'id', value: user.id.toString()),
                    AppHelpers.buildRowItem(
                        title: 'First name', value: user.firstName),
                    AppHelpers.buildRowItem(
                        title: 'Last name', value: user.lastName),
                    AppHelpers.buildRowItem(title: 'Email', value: user.email),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
