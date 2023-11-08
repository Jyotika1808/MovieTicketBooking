import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';

Future<dynamic> customDialogBox({
  required BuildContext context,
  required String content,
  required String buttonText,
  required VoidCallback onTap,
  required double height,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.r,
          ),
        ),
        content: Container(
          height: height,
          width: 300.w,
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
                  top: 25.h,
                  bottom: 25.h,
                ),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                      ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    width: 1.sw,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppConstant.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          20.r,
                        ),
                        bottomRight: Radius.circular(
                          20.r,
                        ),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
