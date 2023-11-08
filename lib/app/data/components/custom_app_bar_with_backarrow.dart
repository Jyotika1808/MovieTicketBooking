import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';

AppBar customAppBarWithBackArrow({
  required BuildContext context,
  required String text,
}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppConstant.subtitleColor,
      statusBarIconBrightness:
          Get.isDarkMode ? Brightness.dark : Brightness.light,
      statusBarBrightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: Colors.black,
          ),
    ),
    leading: IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Get.back();
      },
      icon: Platform.isAndroid
          ? const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )
          : const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
    ),
  );
}
