
import 'package:flutter/material.dart';
import '../manager/color_manager.dart';
import '../manager/font_manager.dart';

class CustomTextField extends StatefulWidget {
  final String? floatingTitle;
  final String hint;
  final double? radius;
  final double? height;
  final bool? isPassword;
  final IconData? icon;
  final double? verticalPadding;
  final bool? isNumberOnly;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final IconData? trailIcon;
  final int? maxline;

  const CustomTextField(
      {super.key,
      this.maxline,
      this.suffix,
      this.onChanged,
      this.height,
      this.trailIcon,
      this.radius,
      this.floatingTitle,
      required this.hint,
      this.isPassword,
      this.icon,
      this.verticalPadding,
      required this.validator,
      this.isNumberOnly,
      this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword ?? false;
  }

  @override
  Widget build(BuildContext context) {
    widget.radius ?? 10;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.floatingTitle == null
            ? SizedBox()
            : Text(
                widget.floatingTitle!,
                style: appFont.f14w500Black,
              ),
        SizedBox(
          height: widget.height ?? 10,
        ),
        Container(
          height: widget.suffix == null ? null: 60,
          child: TextFormField(
            onChanged: widget.onChanged,
              obscureText: obscure,
              maxLines: widget.maxline,
              style: appFont.f12w500Black,
              cursorColor: appColors.brandDark,
              validator: widget.validator,
              keyboardType: widget.isNumberOnly ?? false
                  ? TextInputType.number
                  : TextInputType.text,
              controller: widget.controller,
              decoration: InputDecoration(
                suffix: widget.suffix,
                prefixIcon: widget.icon == null
                    ? null
                    : Icon(
                        widget.icon,
                        size: 25,
                        color: appColors.brandDark,
                      ),
                suffixIcon: widget.isPassword ?? false
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: SizedBox(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                obscure
                                    ? Icons.remove_red_eye
                                    : Icons.hide_source,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      )
                    : widget.trailIcon == null
                        ? null
                        : Icon(
                            widget.trailIcon,
                            color: Colors.grey,
                          ),
                counter: const SizedBox(),
                hintText: widget.hint,
                hintStyle: appFont.f14w400Grey,
                disabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColors.appGrey,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColors.appGrey,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: appColors.appGrey),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10))),
          ),
        ),
      ],
    );
  }
}
