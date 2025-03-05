import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/base_assets.dart';

class BaseScaffoldBackground extends StatelessWidget {
  final Widget child;
  final bool image;

  const BaseScaffoldBackground({super.key, required this.child, this.image = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (image) ...[
          Positioned(
            bottom: -10,
            left: -230,
            right: 0,
            child: Stack(
              children: [
                SvgPicture.asset(BaseAssets.backgroundFirstIc),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY:20),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -10,
            right: -160,
            child: Stack(
              children: [
                SvgPicture.asset(BaseAssets.backgroundSecondIc),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],
        child,
      ],
    );
  }
}
