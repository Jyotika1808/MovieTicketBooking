import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/app/data/components/another_user_input_field.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/components/custom_elevated_button.dart';
import 'package:movie_ticket_booking/app/data/components/user_header_text.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/data/services/models/movie_details_model.dart';
import 'package:movie_ticket_booking/app/modules/home/controllers/home_controller.dart';

class BookTicketView extends GetView<HomeController> {
  const BookTicketView({
    Key? key,
    required this.movieDetailsModel,
  }) : super(key: key);
  final MovieDetailsModel movieDetailsModel;
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final idController = TextEditingController(
      text: firebaseAuth.currentUser!.uid,
    );
    final movieTitleController = TextEditingController(
      text: movieDetailsModel.originalTitle,
    );
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.subtitleColor,
          statusBarIconBrightness:
              Get.isDarkMode ? Brightness.dark : Brightness.light,
          statusBarBrightness:
              Get.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Book Ticket',
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
            controller.selectTimeEmpty();
            controller.selectDateEmpty();
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
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  const UserHeaderText(
                    text: "Name",
                  ),
                  AnotherUserInputField(
                    controller: nameController,
                    hintText: 'Enter name',
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const UserHeaderText(
                    text: "Email",
                  ),
                  AnotherUserInputField(
                    controller: emailController,
                    hintText: 'Enter email',
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const UserHeaderText(
                    text: "Contact No.",
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    autofocus: false,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefix: Text(
                        '+91',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 15.sp,
                              color: Colors.black,
                            ),
                      ),
                      contentPadding: const EdgeInsets.only(),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color(0xffB2B2B2),
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color(0xffB2B2B2),
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color(0xffB2B2B2),
                          style: BorderStyle.solid,
                        ),
                      ),
                      filled: true,
                      hintStyle:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                      hintText: "Enter phone number",
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const UserHeaderText(
                    text: "Customer ID",
                  ),
                  AnotherUserInputField(
                    controller: idController,
                    readOnly: true,
                    hintText: 'Enter id',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const UserHeaderText(
                    text: "Movie Title",
                  ),
                  AnotherUserInputField(
                    controller: movieTitleController,
                    readOnly: true,
                    hintText: 'Movie name',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const UserHeaderText(
                    text: "No. of tickets",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => controller.decrement(),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Obx(
                        () => Text(
                          '${controller.ticketCount}',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      GestureDetector(
                        onTap: () => controller.increment(),
                        child: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const UserHeaderText(
                    text: "Select Date*",
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GridView.builder(
                    itemCount: controller.dateSlotList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5,
                    ),
                    itemBuilder: (context, index) {
                      final dateSlot = controller.dateSlotList[index];
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.selectDateSlot(dateSlot);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.h,
                              horizontal: 4.w,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: controller.selectedDateSlot.value ==
                                        dateSlot
                                    ? Colors.blue.withOpacity(0.6)
                                    : Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "${DateFormat.MMM().format(dateSlot.date!)} ${dateSlot.date!.day}, ${dateSlot.date!.year}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const UserHeaderText(
                    text: "Select time slot*",
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GridView.builder(
                    itemCount: controller.timeSlotList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5,
                    ),
                    itemBuilder: (context, index) {
                      final timeSlot = controller.timeSlotList[index];
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.selectTimeSlot(timeSlot);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.h,
                              horizontal: 4.w,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: controller.selectedTimeSlot.value ==
                                        timeSlot
                                    ? Colors.blue.withOpacity(0.6)
                                    : Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  timeSlot.time,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Note: ',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                      children: [
                        TextSpan(
                          text: "Every movie ticket is of ₹200 each.",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.makePayment(
                          userName: nameController.text,
                          userEmail: emailController.text,
                          movieTitle: movieTitleController.text,
                          numberOfTickets: controller.ticketCount.value,
                          selectedDate:
                              "${DateFormat.MMM().format(controller.selectedDateSlot.value!.date!)} ${controller.selectedDateSlot.value!.date!.day}, ${controller.selectedDateSlot.value!.date!.year}",
                          selectedTime: controller.selectedTimeSlot.value!.time,
                          amount: '${controller.ticketCount * 200}',
                          currency: 'INR',
                          context: context,
                        );
                      }
                    },
                    width: 1.sw,
                    child: Text(
                      "Proceed to Pay",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
