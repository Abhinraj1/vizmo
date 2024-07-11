import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../maanger/image_manager.dart';


class EventDetailsScreenBackground extends StatelessWidget {
  final Widget child;
  const EventDetailsScreenBackground({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
     height: 100.h,
      width: 100.w,
      decoration:  const BoxDecoration(
        image: DecorationImage(
            image:AssetImage(eventDetailsScreenBackgroundImage),
            fit: BoxFit.cover
        )
      ),
      child: SafeArea(
        child: GlassContainer(
          margin: EdgeInsets.symmetric(vertical:3.h,horizontal: 4.w),
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.shade800.withOpacity(0.2),
          borderColor: Colors.white.withOpacity(0.1),
          blur: 5.0,
          borderWidth: 4,
          elevation: 3.0,
          isFrostedGlass: false,
          shadowColor: Colors.black.withOpacity(0.20),
          alignment: Alignment.center,
          frostedOpacity: 0.2,
          child: child,
        ),
      ),
    );
  }
}
