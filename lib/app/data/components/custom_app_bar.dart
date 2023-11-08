import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';

AppBar customAppBar({
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
    centerTitle: true,
    title: Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: Colors.black,
          ),
    ),
  );
}
