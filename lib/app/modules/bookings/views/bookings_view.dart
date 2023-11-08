import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/components/custom_app_bar.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/modules/bookings/views/widgets/booking_widget.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        text: 'Bookings',
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        color: AppConstant.primaryColor,
        backgroundColor: Colors.white,
        strokeWidth: 3.w,
        onRefresh: () async {
          controller.fetchBookings();
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: ListView(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => controller.loadingStatus.value == LoadingStatus.loading
                    ? SizedBox(
                        height: 1.sh,
                        width: 1.sw,
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : controller.listOfbookings.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: 250.h,
                              ),
                              Center(
                                child: Text(
                                  "No bookings yet.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        fontSize: 20.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: controller.listOfbookings
                                .map(
                                  (payment) => BookingWidget(
                                    bookingModel: payment,
                                  ),
                                )
                                .toList(),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
