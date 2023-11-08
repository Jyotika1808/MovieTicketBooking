import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';

Future<dynamic> customAlertDialogBox({
  required BuildContext context,
  required String headText,
  required String bodyText,
  required double height,
  required VoidCallback tapLeftButton,
  required VoidCallback tapRightButton,
  required String leftButtonText,
  required String rightButtonText,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20.r,
            ),
          ),
          content: Container(
            height: height,
            width: 1.sw,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                  ),
                  child: Column(
                    children: [
                      Text(
                        headText,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        bodyText,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 14.sp,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Divider(
                  color: Colors.grey,
                  thickness: 0.5.w,
                  height: 0.h,
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: tapLeftButton,
                          child: Container(
                            height: 1.sh,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppConstant.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  20.r,
                                ),
                              ),
                            ),
                            child: Text(
                              leftButtonText,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: AppConstant.appWhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1.sh,
                        width: 1.w,
                        color: const Color.fromARGB(255, 123, 123, 123),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: tapRightButton,
                          child: Text(
                            rightButtonText,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
