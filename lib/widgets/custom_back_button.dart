import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.backGroundColor,
    this.iconColor,
    this.onClick,
  });

  final Color? backGroundColor;
  final Color? iconColor;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            width: 52,
            height: 47,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backGroundColor ?? Colors.white,
                border: Border.all(color: backGroundColor ?? AppColors.BLACK)),
            child: MaterialButton(
                padding: EdgeInsets.zero,
                minWidth: 0,
                onPressed: onClick == null ? () => Get.back() : onClick!,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.keyboard_arrow_left_sharp,
                  color: iconColor ?? AppColors.DARK_BLUE,
                  size: 30,
                )),
          ),
        ),
      ],
    );
  }
}
