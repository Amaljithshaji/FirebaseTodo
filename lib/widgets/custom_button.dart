import 'package:flutter/material.dart';
import '../manager/color_manager.dart';
import '../utils/get_dimension.dart';

class CustomButton extends StatelessWidget {
  final TextStyle? titleStyle;
  final Function onTap;
  final Widget title;
  final double? verticalPadding;
  final double? borderRadius;
  final bool? borderButton;
  final double? buttonWidth;
  final double? buttonHeight;
  final bool? maxWidth;
  final bool? delete;
  const CustomButton(
      {super.key,
      this.titleStyle,
      this.borderRadius,
      required this.onTap,
      required this.title,
      this.verticalPadding,
      this.borderButton,
      this.buttonWidth,
      this.buttonHeight,
      this.delete,
      this.maxWidth});

  @override
  Widget build(BuildContext context) {
    double radius = borderRadius == null ? 8 : borderRadius!;
    AppColors appColors = AppColors();
    
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 10),
        child: InkWell(
          onTap: () {
            onTap();
          },
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              border: borderButton ?? false
                  ? Border.all(
                      color: appColors.brandDark,
                      width: 1.5,
                    )
                  : null,
              color: delete == true
                  ? Colors.red
                  : borderButton ?? false
                      ? Colors.transparent
                      : appColors.brandDark,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(radius),
                  right: Radius.circular(radius)),
            ),
            child: SizedBox(
              width: maxWidth ?? false
                  ? getDimension(context: context, horizontalPadding: 30).w
                  : buttonWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: borderButton ?? false ? 8 : buttonHeight ?? 10),
                child: title
              ),
            ),
          ),
        ),
      ),
    );
  }
}
