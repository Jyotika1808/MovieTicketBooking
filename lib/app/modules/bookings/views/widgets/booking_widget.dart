import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_ticket_booking/app/data/services/models/booking_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class BookingWidget extends StatelessWidget {
  const BookingWidget({
    super.key,
    required this.bookingModel,
  });
  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
        bottom: 15.w,
      ),
      child: Container(
        padding: EdgeInsets.all(
          8.spMax,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10.r,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.r,
            ),
          ],
        ),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      bookingModel.movieTitle,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Number of tickets : ${bookingModel.numberOfTickets}',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const Spacer(),
                      Text(
                        "₹ ${bookingModel.amount}",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookingModel.date,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 16, 116, 237),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    returnDate(),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                  Text(
                    bookingModel.status,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 16.sp,
                          color: bookingModel.status == 'Success'
                              ? Colors.green
                              : bookingModel.status == 'Failed'
                                  ? Colors.red
                                  : null,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String returnDate() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        bookingModel.createdAt.millisecondsSinceEpoch);
    return timeago.format(dateTime);
  }
}
