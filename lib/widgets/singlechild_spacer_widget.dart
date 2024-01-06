import 'package:flutter/material.dart';

class SingleChildSpacerWidget extends StatelessWidget {
  SingleChildSpacerWidget(
      {super.key, required this.child, this.scrollController});

  final Widget child;
  final ScrollController? scrollController;
  final ScrollController sController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        controller: scrollController ?? sController,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(child: child),
        ),
      );
    });
  }
}
