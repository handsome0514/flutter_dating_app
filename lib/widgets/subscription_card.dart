import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/subscription/subscriptionPlan_screen2/subscription_plan_screen2.dart';
import '../utils/constants.dart';

class SubScriptionCard extends StatelessWidget {
  const SubScriptionCard({
    super.key,
    required this.label,
    required this.price,
    required this.description,
    this.recomendationlabel,
  });

  final String label;
  final String? recomendationlabel;
  final String description;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 282,
        decoration: BoxDecoration(
            //  color: Colors.red,
            border: Border.all(color: AppColors.themeColor, width: 5),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              color: AppColors.themeColor,
              child: Center(
                child: Text(
                  recomendationlabel ?? '',
                  style: const TextStyle(
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: AppColors.WHITE,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontFamily: AppFonts.INTER_MEDIUM,
                color: Color(0xff162534),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: AppFonts.INTER_REGULAR,
                  color: Color(0xff162534),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              //  mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: AppFonts.INTER_SEMIBOLD,
                    color: AppColors.themeColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    '/mo',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: AppColors.themeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 17, right: 17),
              child: Text(
                'Start your free 2-week trial today. Cancel anytime. We’ll send you a reminder 7 days before your trial ends.',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.INTER_REGULAR,
                  color: Color(0xff162534),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => SubScriptionPlanScreen2(
                      price: price,
                    ));
              },
              child: Container(
                height: 52,
                width: 168,
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text(
                    'Activate',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: AppColors.WHITE,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
