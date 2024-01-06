import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/constants.dart';

class SelectDropList extends StatefulWidget {
  final String selectedItem;
  final List<String> itemList;
  final Function(String) onSelected;

  const SelectDropList({
    super.key,
    required this.selectedItem,
    required this.itemList,
    required this.onSelected,
  });

  @override
  SelectDropListState createState() => SelectDropListState();
}

class SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  late String itemSelected;
  late AnimationController expandController;
  late Animation<double> animation;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    itemSelected = widget.selectedItem;
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.linear,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (widget.itemList.isEmpty) return;
            isShow = !isShow;
            _runExpandCheck();
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xffEB4887),
                  Color(0xff8A52F3),
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(60)),
            child: Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.only(
                  top: 16, bottom: 17, left: 31, right: 38),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      itemSelected,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: AppFonts.INTER_MEDIUM,
                        color: Color(0xff33196B),
                      ),
                    ),
                  ),
                  SvgPicture.asset(SvgAssets.DOWN_ARROW_ICON),
                ],
              ),
            ),
          ),
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: animation,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xffEB4887),
                  Color(0xff8A52F3),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                borderRadius: BorderRadius.circular(60)),
            child: Container(
             margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.LOCATION_COLOR, width: 2),
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: _buildDropListOptions(
                  widget.itemList,
                  context,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildDropListOptions(List<String> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(String item, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        itemSelected = item;
        isShow = false;
        expandController.reverse();
        widget.onSelected(item);
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(item,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: AppFonts.INTER_REGULAR,
                    color: Color(0xff33196B),
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis),
            ),
            Divider(color: AppColors.SILICON_VELLEY.withOpacity(.25)),
          ],
        ),
      ),
    );
  }
}
