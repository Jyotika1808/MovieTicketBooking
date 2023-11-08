import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

mixin AppConstant {
  static const Color primaryColor = Color.fromARGB(255, 131, 75, 214);
  static const Color secondaryColor = Color.fromARGB(255, 201, 141, 231);
  static const Color backgroundColor = Color(0xffF4F4F4);
  static const Color titleColor = Color(0xff121013);
  static const Color subtitleColor = Color(0xffA6A4A7);
  static const Color appBlack = Color.fromARGB(255, 0, 0, 0);
  static const Color appWhite = Color.fromARGB(255, 255, 255, 255);

  static const String stripeSecretKey =
      '.........................................................................';
  static showLoader({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            height: 200.h,
            width: 250.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            child: Platform.isAndroid
                ? const CircularProgressIndicator(
                    color: AppConstant.primaryColor,
                  )
                : CupertinoActivityIndicator(
                    radius: 15.r,
                    color: AppConstant.primaryColor,
                  ),
          ),
        );
      },
    );
  }

  static showSnackbar({
    required String headText,
    required String content,
    required SnackPosition position,
  }) {
    return Get.snackbar(
      headText,
      content,
      duration: const Duration(seconds: 2),
      snackPosition: position,
    );
  }

  static showSocketExceptionError() {
    return Get.snackbar(
      "Failed",
      "You are offline.",
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
