import 'package:bematched/models/story_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/storyview/widgets/story_view.dart';
import 'status_screen_controller.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen(
      {super.key,
      required this.index,
      required this.list,
      required this.storyModel});

  final int index;
  final List<StoryItem> list;
  final StoryModel storyModel;

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final StatusScreenController _controller = Get.put(StatusScreenController());
  late PageController pagecontroller;

  @override
  void initState() {
    pagecontroller = PageController(initialPage: widget.index);
    if (kDebugMode) print(widget.index);
    super.initState();
  }

  @override
  void dispose() {
    pagecontroller.dispose();
    if (kDebugMode) print('listener disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   StoryItem.pageVideo(url, controller: controller)

    return Scaffold(
      body: StoryView(
        storyItems: widget.list,
        onStoryShow: (story) {},
        controller: _controller.storycontroller,
        onComplete: () {
          //   _controller.storyitemslist[index].
          //    Get.back();
        },
        storyModel: widget.storyModel,
      ),
    );
  }
}
