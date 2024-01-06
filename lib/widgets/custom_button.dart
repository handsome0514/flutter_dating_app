import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonLabel,
    this.onTap,
    this.borderRadius,
    this.borderColor,
    this.textColor,
    this.buttonColor,
  });

  final String buttonLabel;
  final Function()? onTap;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(15),
          border: Border.all(color: borderColor ?? Colors.transparent),
          color: buttonColor ?? AppColors.themeColor,
        ),
        child: Center(
          child: Text(
            buttonLabel,
            style: TextStyle(
                fontSize: 23,
                color: textColor ?? AppColors.whiteColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
