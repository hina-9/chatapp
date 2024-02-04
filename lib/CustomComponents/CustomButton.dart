import 'package:chitchat/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? mywidget;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double buttonHeight;
  final double buttonWidth;
  final VoidCallback onPress;
  const CustomButton(
      {super.key,
      this.mywidget,
      required this.onPress,
      this.backgroundColor,
      this.borderColor,
      required this.buttonHeight,
      required this.buttonWidth,
      this.text,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          alignment: Alignment.center,
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
              border:
                  Border.all(color: borderColor ?? AppColors.textWhiteColor),
              borderRadius: BorderRadius.circular(15),
              color: backgroundColor),
          child: mywidget ??
              Text(
                text ?? 'Click Me',
                style: TextStyle(fontWeight: FontWeight.w700, color: textColor),
              )),
    );
  }
}
