import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tafeel_task/theme/styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBackBtn;
  final String title;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Function? backButtonAction;

  @override
  final Size preferredSize;

  const CustomAppbar(
      {Key? key,
      this.hasBackBtn = false,
      this.leadingWidget,
      required this.title,
      this.backButtonAction,
      this.preferredSize = const Size.fromHeight(50.0),
      this.trailingWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Styles.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leadingWidget ??
              (hasBackBtn
                  ? Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(left: 5, top: 20),
                      child: GestureDetector(
                        onTap: () => backButtonAction ?? Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                      ))
                  : const SizedBox(
                      width: 40,
                      height: 40,
                    )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Spacer(),
          trailingWidget != null
              ? Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 5),
                  child: trailingWidget)
              : Container(
                  width: 40,
                ),
        ],
      ),
    );
  }
}
