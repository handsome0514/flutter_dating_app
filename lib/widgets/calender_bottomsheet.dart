import 'package:bematched/config.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_button.dart';
import 'package:bematched/widgets/custom_calendar.dart';

class CalenderBottomSheet extends StatelessWidget {
  CalenderBottomSheet({super.key});

  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 96),
            CustomCalender(
              onSelected: (val) => date = val,
            ),
            const SizedBox(height: 40),
            CustomButton(
              buttonLabel: 'Save',
              onTap: () => Get.back(result: date),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
