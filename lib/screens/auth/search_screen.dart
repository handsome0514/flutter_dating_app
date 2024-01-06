import 'package:bematched/config.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../utils/constants.dart';
import '../admin_base_controller.dart';
import '../navbar_screen/navbar_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController textEditingController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  final _baseController = BaseController(Get.context, () {});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 45),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Search Location',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: AppFonts.INTER_SEMIBOLD,
                  color: AppColors.BLACK,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          GooglePlaceAutoCompleteTextField(
            boxDecoration: const BoxDecoration(color: Colors.transparent),
            textEditingController: textEditingController,
            googleAPIKey: "AIzaSyA2OFq0vIPnSuzSVrhLM8NlCEkTI2niljU",
            inputDecoration: InputDecoration(
              fillColor: AppColors.whiteColor,
              filled: true,
              contentPadding: const EdgeInsets.only(
                  left: 13, top: 20, bottom: 20, right: 13),
              hintText: 'Search Location.....',
              hintStyle: TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.INTER_REGULAR,
                color: Colors.black.withOpacity(.40),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
              ),
            ),
            debounceTime: 800,
            isLatLngRequired: true,
            // if you required coordinates from place detail
            getPlaceDetailWithLatLng: (Prediction prediction) async {
              // this method will return latlng with place detail
              print("placeDetails${prediction.lng}");
              try {
                _baseController.showProgress();
                var userModel = AdminBaseController.userData.value;
                var address = await placemarkFromCoordinates(
                    double.parse(prediction.lat!),
                    double.parse(prediction.lng!));
                var first = address.first;
                userModel.location =
                    ' ${first.locality}, ${first.subLocality},${first.thoroughfare}, ${first.country}';

                userModel
                  ..flow = 8
                  ..longitude = double.parse(prediction.lng!)
                  ..latitude = double.parse(prediction.lat!)
                  ..firstRegister = Timestamp.now();
                userModel.addNewUserOrUpdate();
                AdminBaseController.updateUser(userModel);
                _baseController.hideProgress();
                Get.offAll(() => NavBarScreen());
              } catch (e) {
                _baseController.hideProgress();
                if (kDebugMode) {
                  print(e);
                }
              }
            },
            // this callback is called when isLatLngRequired is true
            itemClick: (Prediction prediction) {
              /*          controller.text = prediction.description;
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description.length));*/
            },
            // if we want to make custom list item builder
            itemBuilder: (context, index, Prediction prediction) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 7),
                    Expanded(child: Text(prediction.description ?? ""))
                  ],
                ),
              );
            },
            // if you want to add seperator between list items
            seperatedBuilder: const Divider(),
            // want to show close icon
            isCrossBtnShown: false,
          ),
          /*  CustomTextField(hintLabel: 'Search'),
          Expanded(child: Container(color: Colors.green))*/
        ],
      ),
    );
  }
}
