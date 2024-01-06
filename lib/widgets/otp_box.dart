import 'package:flutter/material.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class OtpBox extends StatelessWidget {
  OtpBox({super.key, required this.index, required this.controller});
  final String index;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      // width: 55,
      constraints: const BoxConstraints(
        maxWidth: 55,
      ),
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColor.LIGHT_PINK,
        )
      ),*/
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          fontSize: 26,
          fontFamily: AppFonts.INTER_SEMIBOLD,
          color: AppColors.DARK_BLUE,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorColor: AppColors.DARK_BLUE,
        maxLength: 1,
        onChanged: (val) {
          if (val.length == 1 && index != '6') {
            FocusScope.of(context).nextFocus();
          } else if (val.isEmpty && index != '1') {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 30, bottom: 30),
          counterText: '',
          border: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: AppColors.themeColor,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: AppColors.themeColor,
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: AppColors.themeColor,
          )),
        ),
      ),
    );
  }
}
