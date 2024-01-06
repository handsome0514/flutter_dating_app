import 'package:bematched/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/extension.dart';

class SubScriptionPlanScreen2 extends StatelessWidget {
  const SubScriptionPlanScreen2({super.key, required this.price});
  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: SingleChildScrollView(
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
              const Text(
                'Start your 2-week\nFREE trial',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: AppFonts.INTER_SEMIBOLD,
                  color: Color(0xff162534),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              const Text(
                'There are no hidden fees or contracts, and you can cancel at any time. Come for love, embrace the journey, and leave whenever you’re ready.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppFonts.INTER_REGULAR,
                  color: Color(0xff162534),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Card Number',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: AppFonts.INTER_MEDIUM,
                    color: Color(0xff162534),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 19,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberFormatter(),
                ],
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '0000-0000-0000-0000',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.INTER_REGULAR,
                    color: Color(0xff162534),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.themeColor, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xff162534), width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xff162534), width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expiry',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: Color(0xff162534),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CardExpirationFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '00/00',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.INTER_REGULAR,
                              color: Color(0xff162534),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff162534), width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff162534), width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff162534), width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CVC',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: Color(0xff162534),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextFormField(
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '000',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.INTER_REGULAR,
                              color: Color(0xff162534),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff162534), width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff162534), width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff162534), width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 34),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 16.5, right: 16.5, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 15.5,
                          ),
                          const Text(
                            'After Free Trial',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.INTER_MEDIUM,
                              color: AppColors.WHITE,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$$price/month ',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFonts.INTER_REGULAR,
                                  color: AppColors.WHITE,
                                ),
                              ),
                              Text(
                                '(\$${(double.parse(price) * 12).toStringAsFixed(2)} billed annually)',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFonts.INTER_REGULAR,
                                  color: AppColors.WHITE,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'A recurring monthly/yearly charge of US\$120.00 (plus tax, where applicable) will automatically be applied to your payment method and start on April 6, 2023. You may cancel at any time, effective at the end of the billing period, by going to your payment settings. Rates for subsequent years may change. All amounts paid are non-refundable, subject to certain exceptions. By clicking \'Start Your 2-week Free Trial\', you agree to our and authorize this recurring charge.',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: AppColors.WHITE),
                      ),
                      const SizedBox(height: 31),
                      InkWell(
                        child: Container(
                          height: 52,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.WHITE,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'Start Your Free Trial',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppFonts.INTER_MEDIUM,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 89),
            ],
          ),
        ),
      ),
    );
  }
}
