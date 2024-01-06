import 'package:flutter/material.dart';

import '../../../utils/constants.dart';




class UpdateConnectionBox extends StatelessWidget {
  const UpdateConnectionBox(
      {super.key,
        required this.isSelected,
        required this.title,
        required this.description,
        this.onTap});

  final bool isSelected;
  final String title;
  final String description;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected
              ? AppColors.themeColor
              : AppColors.whiteColor,
        ),
        margin: const EdgeInsets.all(8),
        padding:
        const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 3),
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color:
                  isSelected ? AppColors.whiteColor : AppColors.themeColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  height: 9,
                  width: 9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.5),
                    color: AppColors.whiteColor,
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(width: 11),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppFonts.INTER_REGULAR,
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.themeColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: AppFonts.INTER_REGULAR,
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.themeColor.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
