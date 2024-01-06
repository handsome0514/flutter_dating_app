import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AnimatedContainerSwitch extends StatefulWidget {
  const AnimatedContainerSwitch(
      {super.key, required this.ison, required this.onChanged, this.onClick});

  final bool ison;
  final ValueChanged<bool> onChanged;
  final Function()? onClick;

  Future<void> ontaphandle() async {}

  @override
  State<AnimatedContainerSwitch> createState() =>
      _AnimatedContainerSwitchState();
}

class _AnimatedContainerSwitchState extends State<AnimatedContainerSwitch> {
  final Color _backgroundcolor = AppColors.GREY.withOpacity(.5);
  final Color _ballColor = AppColors.GREY;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        //widget. ison =!widget.ison;
        widget.onChanged(!(widget.ison));
        setState(() {});
      },
      child: AnimatedContainer(
        alignment: widget.ison ? Alignment.topRight : Alignment.topLeft,
        height: 28,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.8),
          color: AppColors.whiteColor,
        ),
        duration: const Duration(milliseconds: 150),
        curve: Curves.fastOutSlowIn,
        child: Padding(
          padding: const EdgeInsets.all(4.8),
          child: AnimatedContainer(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(100.8),
              color: widget.ison ? AppColors.themeColor : AppColors.GREY,
            ),
            duration: const Duration(milliseconds: 150),
            curve: Curves.fastOutSlowIn,
          ),
        ),
      ),
    );
  }
}
