import 'package:bematched/utils/constants.dart';

import '../../config.dart';
import '../../widgets/swipe_card.dart';

class BFFBox extends StatelessWidget {
  const BFFBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SwipeCard(
          image: ImageAssets.DUMY_IMAGE,
        ),
        SwipeCard(
          image: ImageAssets.DUMY_IMAGE1,
        ),
        SwipeCard(
          image: ImageAssets.DUMY_IMAGE,
        ),
        SwipeCard(
          image: ImageAssets.DUMY_IMAGE1,
        ),
      ],
    );
  }
}
