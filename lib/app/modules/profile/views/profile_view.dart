import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/components/custom_alert_dialog_box.dart';
import 'package:movie_ticket_booking/app/data/components/custom_app_bar.dart';
import 'package:movie_ticket_booking/app/data/components/image_paths.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        text: '',
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45.r,
                backgroundColor: AppConstant.appWhite,
                child: Image.asset(
                  userIcon,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.user.name,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 20.sp,
                                color: AppConstant.appBlack,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      controller.user.email,
                      maxLines: 2,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 16.sp,
                                color: AppConstant.appBlack.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  customAlertDialogBox(
                    context: context,
                    headText: "Logout",
                    bodyText: "Are you sure you want to\nlogout from app?",
                    height: Platform.isAndroid ? 145.h : 140.h,
                    leftButtonText: "Logout",
                    rightButtonText: "Cancel",
                    tapLeftButton: () {
                      AppConstant.showLoader(context: context);
                      controller.signOut();
                    },
                    tapRightButton: () {
                      Get.back();
                    },
                  );
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      const Icon(
                        Icons.logout,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Logout",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
