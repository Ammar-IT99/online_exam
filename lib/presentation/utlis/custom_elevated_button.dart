import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/constants/app_strings.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? radius;
  final void Function() onTap;
  final TextStyle? textStyle;
  final bool isStadiumBorder;

  const CustomElevatedButton({
    super.key,
    this.prefixIcon,
    this.textStyle,
    this.isStadiumBorder = true,
    this.backgroundColor,
    this.borderColor,
    this.radius,
    this.suffixIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: isStadiumBorder
              ? StadiumBorder(side: BorderSide(color: borderColor?? AppColors.blueBase,))
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.r)),
          backgroundColor: backgroundColor ?? AppColors.blueBase,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon ?? const SizedBox(),
            SizedBox(
              width: 24.w,
            ),
            Text(
              label,
              style: textStyle ??
                  TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 27.w,
            ),
            suffixIcon ?? const SizedBox()
          ],
        ));
  }
}
