import 'package:bematched/config.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/auth/search_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/custom_button.dart';
import 'location_screen_controller.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key, this.isBack});

  final bool? isBack;

  final _controller = Get.put(LocationScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LocationScreenController>(
        builder: (controller) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                LinearProgressIndicator(
                  backgroundColor: const Color(0xFFD9D9D9),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.black,
                  ),
                  value: 1,
                  borderRadius: BorderRadius.circular(20),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Where are you located?',
                    style: GoogleFonts.playfairDisplay(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Obx(
                  () => (_controller.isNotPermision.value == false)
                      ? SizedBox(
                          height: 219,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: _controller.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Stack(
                                    children: [
                                      GoogleMap(
                                        zoomControlsEnabled: false,
                                        //   myLocationEnabled: true,
                                        mapType: MapType.normal,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              _controller
                                                  .currentLocation!.latitude!,
                                              _controller
                                                  .currentLocation!.longitude!),
                                          zoom: 14.4746,
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: GestureDetector(
                                            onTap: () async {
                                              var result = await Get.to(
                                                () => const SearchScreen(),
                                                transition:
                                                    Transition.rightToLeft,
                                              );
                                              if (result != null) {
                                                newLatLng newLocation =
                                                    newLatLng()
                                                      ..latitude = double.parse(
                                                          (result as Prediction)
                                                              .lat!)
                                                      ..longitude =
                                                          double.parse(
                                                              (result).lng!);
                                                _controller.currentLocation =
                                                    newLocation;
                                                _controller.update();
                                              }
                                            },
                                            child: const Icon(Icons.search)),
                                      )
                                    ],
                                  ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Location is not Provided.',
                            style: GoogleFonts.playfairDisplay(
                              textStyle: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 25),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '8 / 8',
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (isBack ?? false)
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              borderRadius: BorderRadius.circular(50),
                              buttonLabel: 'Back',
                              onTap: Get.back,
                              borderColor: AppColors.themeColor,
                              buttonColor: AppColors.whiteColor,
                              textColor: AppColors.themeColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              borderRadius: BorderRadius.circular(50),
                              buttonLabel: 'Start',
                              onTap: _controller.setLocation,
                            ),
                          ),
                        ],
                      )
                    else
                      CustomButton(
                        borderRadius: BorderRadius.circular(50),
                        buttonLabel: 'Start',
                        onTap: _controller.setLocation,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
