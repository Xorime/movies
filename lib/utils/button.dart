// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies/base/base_controllers.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/wgt.dart';

class Button extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color backgroundColor, textColor, disabledBackgroundColor, disabledTextColor;
  final EdgeInsets? padding;
  final Icon? icon;
  final Widget? leading;
  final Color? borderColor;
  final Function()? handler;
  final BaseControllers? controllers;
  final Key? keyBtn;
  final double? radius;
  final Size? minimumSize;

  const Button(
      {Key? key,
      this.keyBtn,
      required this.text,
      this.textSize,
      this.handler,
      this.radius,
      this.backgroundColor = kColorPrimaryBlue,
      this.textColor = kColorWhite,
      this.disabledBackgroundColor = kColorCoolGray,
      this.disabledTextColor = kColorWhite,
      this.padding,
      this.borderColor,
      this.icon,
      this.controllers,
      this.leading,
      this.minimumSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controllers != null) {
      return Obx(() => _btn());
    }

    return _btn();
  }

  Widget _btn() {
    return ElevatedButton(
        key: keyBtn,
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.resolveWith((states) {
            return minimumSize ?? Size(kSizeMinButtonWidth, kSizeMinButtonHeight);
          }),
          side: borderColor != null
              ? WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return BorderSide(
                      color: borderColor!.withValues(alpha: 0.5),
                      width: 1,
                    );
                  }
                  return BorderSide(
                    color: borderColor!,
                    width: 1,
                  );
                })
              : null,
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? kSizeRadiusButton),
          )),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: kPadding12)),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledBackgroundColor.withValues(alpha: 0.5);
            }
            return backgroundColor;
          }),
        ),
        onPressed: controllers != null && controllers!.state.value == ControllerState.loading ? null : handler,
        child: _btnContent());
  }

  Widget _btnContent() {
    if (controllers != null) {
      if (controllers?.state.value == ControllerState.loading) {
        return SizedBox(
          height: 25,
          width: 25,
          child: Wgt.loaderController(color: Colors.black),
        );
      }

      return _text();
    }

    return _text();
  }

  Container _text() {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: kPadding12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (leading != null) leading!,
          if (icon != null || leading != null)
            const Padding(
              padding: EdgeInsets.only(left: kPadding8),
            ),
          Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              color: handler != null ? textColor : kColorCoolGray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
