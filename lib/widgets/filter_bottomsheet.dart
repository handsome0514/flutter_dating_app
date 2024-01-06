// ignore_for_file: invalid_use_of_protected_member

import 'package:bematched/config.dart';
import 'package:bematched/models/home_user_filter_model.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/add_language_screen.dart';
import 'package:bematched/widgets/select_drop_list.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Rx<int> distance = Rx(25);
  Rx<int> selectedInterestIn = Rx(0);
  Rx<bool> isUseLocation = Rx(true);
  RxList<int> selectedLanguage = RxList();
  List<String> interestIn = ['Woman', 'Man'];
  List<String> useLocationList = ['enable', 'disable'];
  Rx<int> minAge = Rx(0);
  Rx<int> maxAge = Rx(25);

  @override
  void initState() {
    initFilter();
    // TODO: implement initState
    super.initState();
  }

  void initFilter() async {
    var homeFilter = HomeFilterModel.getUser();
    distance.value = homeFilter.distance!;
    minAge.value = homeFilter.age!.start!;
    maxAge.value = homeFilter.age!.end!;
    selectedInterestIn.value = homeFilter.interestedIn ?? 0;
    selectedLanguage.value = homeFilter.selectedLanguage ?? [];
    isUseLocation.value = homeFilter.useLocation ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.75),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
        color: AppColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 44),
            const Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 30,
                fontFamily: AppFonts.INTER_SEMIBOLD,
                color: Color(0xff33196B),
              ),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Manage and set your preferences to find the best matches for you, keep enjoying!',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppFonts.INTER_MEDIUM,
                  color: Color(0xff645290),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 27),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 23),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Preferred Language(s)',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: Color(0xff33196B),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          var lang = await Get.bottomSheet(
                            AddLanguageScreen(
                                selectLanguage: selectedLanguage.value),
                            isScrollControlled: true,
                            persistent: false,
                            enableDrag: true,
                          );
                          if (lang != null) {
                            selectedLanguage.value.clear();
                            selectedLanguage.value.addAll(lang);
                            setState(() {});
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffEB4887),
                                    Color(0xff8A52F3),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
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
                                  child: Obx(
                                    () => Text(
                                      selectedLanguage.value.isEmpty
                                          ? 'Add Language'
                                          : selectedLanguage
                                              .map((element) =>
                                                  LANGLIST[element])
                                              .toList()
                                              .join(','),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: AppFonts.INTER_MEDIUM,
                                        color: Color(0xff33196B),
                                      ),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(SvgAssets.DOWN_ARROW_ICON),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 23),
                if(AdminBaseController.userData.value.connectionStatus != 1)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Interested In',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.INTER_MEDIUM,
                              color: Color(0xff33196B),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => SelectDropList(
                              selectedItem: interestIn[selectedInterestIn.value],
                              itemList: interestIn,
                              onSelected: (val) => selectedInterestIn.value =
                                  interestIn.indexOf(val),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 23),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Use Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: Color(0xff33196B),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => SelectDropList(
                          selectedItem:
                              useLocationList[isUseLocation.value ? 0 : 1],
                          itemList: useLocationList,
                          onSelected: (val) => isUseLocation.value =
                          useLocationList.indexOf(val) == 0 ? true : false,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 23),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Age Range',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: Color(0xff33196B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(
                          () => Text(
                            '${minAge.value} - ${maxAge.value}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: AppColors.themeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Obx(
                  () => SfRangeSliderTheme(
                    data: SfRangeSliderThemeData(
                      overlayColor: Colors.transparent,
                      activeTrackHeight: 3,
                      inactiveTrackHeight: 3,
                      inactiveTrackColor: const Color(0xff964EE0),
                      activeTrackColor: AppColors.themeColor,
                      thumbRadius: 10,
                      thumbStrokeWidth: 3,
                      thumbStrokeColor: AppColors.themeColor,
                      thumbColor: AppColors.WHITE,
                    ),
                    child: SfRangeSlider(
                      values: SfRangeValues(minAge.value, maxAge.value),
                      onChanged: (onChanged) {
                        minAge.value = (onChanged.start).toInt();
                        maxAge.value = (onChanged.end).toInt();
                      },
                      min: 18,
                      max: 50,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 23),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Distance Range',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.INTER_MEDIUM,
                        color: Color(0xff33196B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Obx(
                      () => Text(
                        '0 - ${distance.value} km',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => SfSliderTheme(
                data: SfSliderThemeData(
                  overlayColor: Colors.transparent,
                  activeTrackHeight: 3,
                  inactiveTrackHeight: 3,
                  inactiveTrackColor: const Color(0xff964EE0),
                  activeTrackColor: AppColors.themeColor,
                  thumbRadius: 10,
                  thumbStrokeWidth: 3,
                  thumbStrokeColor: AppColors.themeColor,
                  thumbColor: AppColors.WHITE,
                ),
                child: SfSlider(
                  value: distance.value,
                  onChanged: (onChanged) {
                    distance.value = (onChanged as double).toInt();
                  },
                  max: 100,
                ),
              ),
            ),
            const SizedBox(height: 44),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        HomeFilterModel.initFilter();
                        initFilter();
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(
                              color: const Color(0xffCC3263), width: 2),
                        ),
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Center(
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: Color(0xffCC3263),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        try {
                          HomeFilterModel homeFilterModel = HomeFilterModel()
                            ..age = Age(start: minAge.value, end: maxAge.value)
                            ..distance = distance.value
                            ..interestedIn = selectedInterestIn.value
                            ..selectedLanguage = selectedLanguage
                            ..useLocation = isUseLocation.value;
                          homeFilterModel.update();
                          final ctrl = Get.find<HomeScreenController>();
                          ctrl.loadUser();
                          Get.back();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffEB4887),
                              Color(0xffCC3263),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Center(
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 23),
          ],
        ),
      ),
    );
  }
}
