import 'package:flutter/material.dart';

import '../../manager/font_manager.dart';
import '../../manager/space_manger.dart';
import '../../utils/get_dimension.dart';

class OrContinueWith extends StatelessWidget {
  const OrContinueWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 1,
            width: screenWidth(context) * 0.27,
            child: const ColoredBox(
              color: Color(0xFF7A7A7A),
            )),
        appSpaces.spaceForWidth10,
        Text(
          'Or continue with',
          style: appFont.f14w400Black,
        ),
        appSpaces.spaceForWidth10,
        SizedBox(
            height: 1,
            width: screenWidth(context) * 0.27,
            child: const ColoredBox(
              color: Color(0xFF7A7A7A),
            )),
      ],
    );
  }
}
