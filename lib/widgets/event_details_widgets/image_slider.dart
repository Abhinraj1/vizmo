import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

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
    return InfiniteCarousel.builder(
      itemCount: imagesList.length,
      itemExtent: 120,
      center: true,
      anchor: 0.0,
      velocityFactor: 0.2,
      onIndexChanged: (index) {},
      controller: _controller,
      axisDirection: Axis.horizontal,
      loop: true,
      itemBuilder: (context, itemIndex, realIndex) {
       return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: kElevationToShadow[2],
            image: DecorationImage(
              image: NetworkImage(imagesList[itemIndex]),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
