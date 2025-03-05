import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../base_components/base_text.dart';
import 'base_assets.dart';

class BaseNoData extends StatelessWidget {
  final String? message;
  final Color? textColor;
  const BaseNoData({super.key, this.message, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           SizedBox(
            height: 100,
              child: OverflowBox(
                minHeight: 100,
                maxHeight: 100,
                minWidth: 100,
                maxWidth: 100,
                  child: Lottie.asset(
                      BaseAssets.noDataLottie,
                    height: 100,
                    width: 100,
                  ),
              ),
          ),
          BaseText(
            value: message??"No Data Found!",
            fontSize: 16,
            color: textColor??Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
