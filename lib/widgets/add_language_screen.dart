import 'package:bematched/utils/constants.dart';

import '../config.dart';

class AddLanguageScreen extends StatefulWidget {
  const AddLanguageScreen({super.key, required this.selectLanguage});

  final List<int> selectLanguage;

  @override
  State<AddLanguageScreen> createState() => _AddLanguageScreenState();
}

List<int> selectedLanguage = [];

class _AddLanguageScreenState extends State<AddLanguageScreen> {
  @override
  void initState() {
    selectedLanguage.clear();
    selectedLanguage.addAll(widget.selectLanguage);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.85),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
        color: AppColors.WHITE,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: Get.back, child: const Icon(Icons.close)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '${selectedLanguage.length}/3',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.INTER_BOLD,
                        color: AppColors.BLACK,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back(result: selectedLanguage);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppFonts.INTER_BOLD,
                        color: AppColors.BLACK,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Language they know',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_BOLD,
                          color: AppColors.BLACK,
                        ),
                      ),
                    ),
                    const SizedBox(height: 21),
                    ...List.generate(
                      LANGLIST.length,
                      (index) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (selectedLanguage.contains(index)) {
                            selectedLanguage.remove(index);
                          } else {
                            if (selectedLanguage.length >= 3) return;
                            selectedLanguage.add(index);
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12, bottom: 12, left: 16, right: 16),
                          child: Row(
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: selectedLanguage.contains(index)
                                      ? AppColors.themeColor
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: selectedLanguage.contains(index)
                                        ? Colors.transparent
                                        : AppColors.GREY.withOpacity(.5),
                                    width: 2,
                                  ),
                                ),
                                child: selectedLanguage.contains(index)
                                    ? const Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 12,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                LANGLIST[index],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFonts.INTER_MEDIUM,
                                  color: AppColors.BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
