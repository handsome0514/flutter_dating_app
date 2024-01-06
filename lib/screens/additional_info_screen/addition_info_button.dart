import 'package:flutter/material.dart';

import '../../config.dart';
import '../../utils/constants.dart';

class AdditionalInfoButton extends StatelessWidget {
  const AdditionalInfoButton({super.key, required this.leading, required this.suffix, this.onTap});

  final String leading;
  final String suffix;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 11),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xff737B7D))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leading,
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.INTER_MEDIUM,
                color: const Color(0xff0E0124).withOpacity(.88),
              ),
            ),
            Row(
              children: [
                Text(
                  suffix,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: AppFonts.INTER_REGULAR,
                    color: Color(0xff8E8E8E),
                  ),
                ),
                const Icon(Icons.arrow_drop_down_sharp)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
