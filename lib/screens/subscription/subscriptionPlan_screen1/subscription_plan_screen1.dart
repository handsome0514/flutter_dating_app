import 'package:bematched/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../widgets/subscription_card.dart';

class SubscriptionPlanScreen1 extends StatelessWidget {
  const SubscriptionPlanScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 58),
            Image.asset(
              ImageAssets.logo,
              fit: BoxFit.scaleDown,
              height: 31.33,
              width: 128,
            ),
            const SizedBox(height: 82.87),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Become a Member',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: AppFonts.INTER_SEMIBOLD,
                  color: Color(0xff162534),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Choose the membership tier that’s right for you.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.INTER_REGULAR,
                color: Color(0xff162534),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'All subscriptions include a 2-week free trial, and you can cancel at any time. We’ll also send a reminder 7 days before your trial ends.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.INTER_REGULAR,
                color: Color(0xff162534),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 54),
                  SubScriptionCard(
                    label: 'Standard (Grow)',
                    price: '9.99',
                    description:
                        'Unlock education and inspiration to become the best version of yourself.',
                    recomendationlabel: 'Recommended',
                  ),
                  SubScriptionCard(
                    label: 'Premium: (Discover)',
                    price: '49.9',
                    description:
                        'Unlock a private matchmaking experience that is hands-on and heartfelt',
                  ),
                  SubScriptionCard(
                    label: 'Basic (Connect)',
                    price: '4.9',
                    description:
                        'Create a profile and match with members of the Lamanche community.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 108),
          ],
        ),
      ),
    );
  }
}
