import 'package:flutter/material.dart';

import '../utils/constants.dart';

class GenderSelection extends StatelessWidget {
  const GenderSelection(
      {super.key, required this.isSelected, this.onTap, required this.label});

  final bool isSelected;
  final Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding:
            const EdgeInsets.only(top: 16, bottom: 18, left: 26, right: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.themeColor : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.themeColor : const Color(0xFFD9D9D9),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.white : Colors.black),
            ),
            const Spacer(),
            Icon(
              Icons.done,
              color: isSelected ? Colors.white : const Color(0xFFADAFBB),
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
