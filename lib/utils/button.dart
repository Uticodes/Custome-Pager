import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BawoAppButton extends StatelessWidget {
  Function()? onPressed;
  String title;
  Color disabledColor;
  Color titleColor;
  Color enabledColor;
  bool enabled;
  Widget? icon;
  bool? showFaceIdIcons;

  BawoAppButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.disabledColor,
      required this.titleColor,
      required this.enabledColor,
      required this.enabled,
      this.icon,
      this.showFaceIdIcons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
              vertical: 2.5,
              horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: enabled ? enabledColor : disabledColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: icon)
                    : Container(),
                Text(title, style: TextStyle(
                  color: titleColor,
                  fontSize: 16
                ), )

              ],
            ),
          ),
        ),
        onPressed: enabled ? onPressed : null);
  }
}
