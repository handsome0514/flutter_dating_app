import 'package:bematched/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatListBottomSheet extends StatelessWidget {
  const ChatListBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12),
      decoration: const BoxDecoration(
        color: Color(0xffF2F2F2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18, bottom: 18),
            child: Text(
              'Chat Clear',
              style: TextStyle(
                fontSize: 20,
                fontFamily: AppFonts.INTER_REGULAR,
                color: Color(0xff1E1E1E),
              ),
            ),
          ),
          Divider(color: Colors.black),
          Padding(
            padding: EdgeInsets.only(top: 18, bottom: 18),
            child: Text(
              'Block Canon Frazier',
              style: TextStyle(
                fontSize: 20,
                fontFamily: AppFonts.INTER_REGULAR,
                color: Color(0xffED2F00),
              ),
            ),
          ),
          Divider(color: Colors.black),
          Padding(
            padding: EdgeInsets.only(top: 18, bottom: 18),
            child: Text(
              'Report Canon Frazier',
              style: TextStyle(
                fontSize: 20,
                fontFamily: AppFonts.INTER_REGULAR,
                color: Color(0xff1E1E1E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
