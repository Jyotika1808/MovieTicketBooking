import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final VoidCallback onPressed;
  final Widget child;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: Platform.isAndroid ? 45.h : 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.r,
          ),
          color: AppConstant.primaryColor.withOpacity(0.9),
        ),
        child: child,
      ),
    );
  }
}
