import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../utils/app_cache_image.dart';
import '../utils/constants.dart';

class ProfilePhotosWidget extends StatelessWidget {
  const ProfilePhotosWidget(
      {super.key,
      this.seeAllClicked,
      required this.photosPattern,
      required this.images});

  final Function()? seeAllClicked;
  final List<double> photosPattern;
  final List<dynamic> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Gallery',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.INTER_BOLD,
                color: AppColors.BLACK,
              ),
            ),
            InkWell(
              onTap: seeAllClicked,
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.INTER_REGULAR,
                  color: AppColors.themeColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        if (images.isEmpty)
          const SizedBox(
            height: 200,
            child: Center(
              child: Text('No Photos'),
            ),
          )
        else
          MasonryGridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: images.length >= 4 ? 4 : images.length,
              mainAxisSpacing: 10,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (_, index) {
                return AppCacheImage(
                  imageUrl: images[index],
                  width: null,
                  height: photosPattern[index],
                  round: 8,
                );
              })
      ],
    );
  }
}
