import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/model/event_model.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imagesList;
  const ImageSlider({super.key, required this.imagesList});

  @override
  Widget build(BuildContext context) {

    late InfiniteScrollController _controller =InfiniteScrollController() ;
    if(imagesList.isEmpty){
      return const SizedBox();
    }
    return SizedBox(
      height: 20.h,
      child: InfiniteCarousel.builder(
        itemCount: imagesList.length,
        itemExtent: 120,
        center: true,
        anchor: 5.5,
        velocityFactor: 0.2,
        onIndexChanged: (index) {},
        controller: _controller,
        axisDirection: Axis.horizontal,
        loop: true,
        itemBuilder: (context, itemIndex, realIndex) {
          return Container(

            margin: EdgeInsets.symmetric(horizontal: 1.w),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              boxShadow: kElevationToShadow[2],
              image: DecorationImage(
                image: NetworkImage(imagesList[itemIndex]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
