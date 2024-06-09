import 'package:flutter/material.dart';

import '../../manager/color_manager.dart';

class SocialLogoContainer extends StatelessWidget {
  final String icon;
  const SocialLogoContainer({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: appColors.appGrey)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(icon),
            ),
          ),
        ),
      ),
    );
  }
}
