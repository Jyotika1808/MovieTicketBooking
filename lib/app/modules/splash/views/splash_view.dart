import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/components/image_paths.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(
      SplashController(),
    );
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          color: AppConstant.primaryColor,
        ),
        child: Center(
          child: Image.asset(
            splashLogo,
            height: 200.h,
            width: 1.sw,
          ),
        ),
      ),
    );
  }
}
