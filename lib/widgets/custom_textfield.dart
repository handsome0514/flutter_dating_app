import 'package:bematched/config.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      this.hintLabel,
      this.onChanged,
      this.maxLines,
      this.initialValue,
      this.isPassword});

  final String? hintLabel;
  final int? maxLines;
  final Function(String)? onChanged;
  final String? initialValue;
  final bool? isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      maxLines: widget.maxLines ?? 1,
      style: const TextStyle(
          fontSize: 12,
          fontFamily: AppFonts.INTER_REGULAR,
          color: Colors.black),
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ?? false ? isVisible : false,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword ?? false
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
                child: isVisible
                    ? const Icon(Icons.visibility,color: AppColors.themeColor,)
                    : const Icon(Icons.visibility_off,color: AppColors.themeColor,),
              )
            : null,
        fillColor: AppColors.whiteColor,
        filled: true,
        contentPadding:
            const EdgeInsets.only(left: 13, top: 20, bottom: 20, right: 13),
        hintText: widget.hintLabel ?? '',
        hintStyle: TextStyle(
          fontSize: 12,
          fontFamily: AppFonts.INTER_REGULAR,
          color: Colors.black.withOpacity(.40),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xffD9D9D9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xffD9D9D9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xffD9D9D9)),
        ),
      ),
    );
  }
}
