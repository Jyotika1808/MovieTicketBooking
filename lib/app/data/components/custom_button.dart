import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.borderSideColor,
    required this.textColor,
    required this.textFontSize,
  });
  final VoidCallback onTap;
  final String text;
  final Color borderSideColor;
  final Color textColor;
  final double textFontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: 12.h,
          ),
        ),
        overlayColor: const MaterialStatePropertyAll<Color>(
          Colors.transparent,
        ),
        elevation: const MaterialStatePropertyAll<double>(
          0,
        ),
        shadowColor: const MaterialStatePropertyAll<Color>(
          Colors.white,
        ),
        backgroundColor: const MaterialStatePropertyAll<Color>(
          Colors.white,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15.r,
            ),
            side: BorderSide(
              color: borderSideColor,
              width: 2.w,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: textFontSize,
              color: textColor,
            ),
      ),
    );
  }
}
