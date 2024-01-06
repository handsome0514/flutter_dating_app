import 'package:bematched/config.dart';
import 'package:bematched/utils/constants.dart';


class SubscriptionScreenController extends GetxController {
  List subscriptionList = [
    {
      'icon': SvgAssets.PACKAGE_STAR_ICON,
      'title': 'Starter X',
      'duration': '3 Months',
      'price': '33.00',
    },
    {
      'icon': SvgAssets.DAIMOND_ICON,
      'title': 'Pro Buddy',
      'duration': '6 Months',
      'price': '60.00',
    },
    {
      'icon':SvgAssets.CROWN_ICON,
      'title': 'Advanced U',
      'duration': '12 Months',
      'price': '108.00',
    },
  ];

  Rx<int> selectedIndex = Rx(-1);




}
