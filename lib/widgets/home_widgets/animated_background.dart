import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return  AnimateGradient(
      primaryBeginGeometry: const AlignmentDirectional(0, 1),
      primaryEndGeometry: const AlignmentDirectional(0, 2),
      secondaryBeginGeometry: const AlignmentDirectional(2, 0),
      secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
      textDirectionForGeometry: TextDirection.rtl,

      duration: const Duration(seconds: 10),
      primaryColors: const [
        Colors.indigo,
        Colors.deepPurple

      ],
      secondaryColors: const [
        Colors.deepOrange,
        Colors.deepPurple
      ],
      child: SafeArea(
        child: SizedBox(
          width: 100.w,
            height: 100.h,
            child: GlassContainer(
              margin: EdgeInsets.symmetric(vertical:3.h,horizontal: 4.w),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.4),
                borderColor: Colors.white.withOpacity(0.1),
                blur: 35.0,
                borderWidth: 1,
                elevation: 3.0,
                isFrostedGlass: false,
                shadowColor: Colors.black.withOpacity(0.20),
                alignment: Alignment.center,
                frostedOpacity: 0.2,
                child: child)),
      ),
    );
  }
}
