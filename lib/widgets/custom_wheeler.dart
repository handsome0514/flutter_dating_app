import 'package:bematched/config.dart';
import 'package:bematched/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class CustomWheeler extends StatelessWidget {
  const CustomWheeler(
      {super.key,
      this.initialIndex,
      required this.list,
      required this.onChangedChoice});

  final int? initialIndex;
  final List<String> list;
  final Function(dynamic) onChangedChoice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColors.whiteColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: WheelChooser.choices(
                squeeze: 1,
                //listHeight: 50,
                startPosition: initialIndex,
                selectTextStyle: const TextStyle(
                  fontSize: 17,
                  fontFamily: AppFonts.INTER_REGULAR,
                  color: AppColors.BLACK,
                ),
                unSelectTextStyle: const TextStyle(
                  fontSize: 17,
                  fontFamily: AppFonts.INTER_REGULAR,
                  color: Color(0xff9A99A2),
                ),
                choices: List.generate(
                  list.length,
                  (index) => WheelChoice(
                    value: index,
                    title: list[index],
                  ),
                ),
                onChoiceChanged: onChangedChoice),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
