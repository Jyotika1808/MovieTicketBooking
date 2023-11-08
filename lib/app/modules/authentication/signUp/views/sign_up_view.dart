import 'package:clay_containers/widgets/clay_container.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/components/custom_elevated_button.dart';
import 'package:movie_ticket_booking/app/data/components/image_paths.dart';
import 'package:movie_ticket_booking/app/data/components/user_header_text.dart';
import 'package:movie_ticket_booking/app/data/components/user_input_field.dart';
import 'package:movie_ticket_booking/app/routes/app_pages.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
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
        toolbarHeight: 0.h,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Lottie.asset(
                        signUpAnimation,
                        width: 1.sw,
                        height: 170.h,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'SIGN UP /',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                            fontSize: 22.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              const Shadow(
                                color: Color.fromARGB(255, 206, 206, 206),
                                offset: Offset(
                                  2,
                                  2,
                                ),
                                blurRadius: 3.0,
                              )
                            ],
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const UserHeaderText(
                      text: "Name",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    UserInputField(
                      controller: nameController,
                      icon: Icons.person_outline,
                      hintText: "Enter your name",
                      isNameField: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const UserHeaderText(
                      text: "Email address",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    UserInputField(
                      controller: emailController,
                      icon: Icons.email_outlined,
                      hintText: "Enter your email",
                      isNameField: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email can't be empty";
                        } else if (!EmailValidator.validate(value)) {
                          return "Incorrect email address";
                        }
                        //  else if (!RegExp(
                        //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        //     .hasMatch(value)) {
                        //   return "Please enter a valid email address";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const UserHeaderText(
                      text: "Password",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.password_outlined,
                          color: Colors.black.withOpacity(0.4),
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Obx(
                          () => Expanded(
                            flex: 7,
                            child: ClayContainer(
                              color: AppConstant.backgroundColor,
                              borderRadius: 10.r,
                              depth: -150,
                              spread: 1.0,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: controller.isPasswordHidden,
                                autofocus: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                decoration: InputDecoration(
                                  suffixIconConstraints: BoxConstraints(
                                    minHeight: 20.w,
                                    minWidth: 10.w,
                                    maxHeight: 30.h,
                                    maxWidth: 30.w,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.togglePasswordView();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 10.w,
                                      ),
                                      child: controller.isPasswordHidden
                                          ? SvgPicture.asset(
                                              passwordShow,
                                              height: 20.h,
                                              width: 30.w,
                                            )
                                          : SvgPicture.asset(
                                              passwordHide,
                                              height: 20.h,
                                              width: 30.w,
                                            ),
                                    ),
                                  ),
                                  fillColor:
                                      const Color.fromARGB(255, 244, 244, 244),
                                  filled: true,
                                  hintText: 'Enter password',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    borderSide: BorderSide(
                                      width: 0.w,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password can't  be empty";
                                  }
                                  if (value.length < 6) {
                                    return "Must be of six characters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const UserHeaderText(
                      text: "Confirm Password",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.password_outlined,
                          color: Colors.black.withOpacity(0.4),
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Obx(
                          () => Expanded(
                            flex: 7,
                            child: ClayContainer(
                              color: AppConstant.backgroundColor,
                              borderRadius: 10.r,
                              depth: -150,
                              spread: 1.0,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                obscureText: controller.isConPasswordHidden,
                                autofocus: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                decoration: InputDecoration(
                                  suffixIconConstraints: BoxConstraints(
                                    minHeight: 20.w,
                                    minWidth: 10.w,
                                    maxHeight: 30.h,
                                    maxWidth: 30.w,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.toggleConPasswordView();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 10.w,
                                      ),
                                      child: controller.isConPasswordHidden
                                          ? SvgPicture.asset(
                                              passwordShow,
                                              height: 20.h,
                                              width: 30.w,
                                            )
                                          : SvgPicture.asset(
                                              passwordHide,
                                              height: 20.h,
                                              width: 30.w,
                                            ),
                                    ),
                                  ),
                                  fillColor:
                                      const Color.fromARGB(255, 244, 244, 244),
                                  filled: true,
                                  hintText: 'Enter password again',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    borderSide: BorderSide(
                                      width: 0.w,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password field cannot be empty";
                                  }
                                  if (value != passwordController.text) {
                                    return "Password is not same";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AppConstant.showLoader(context: context);
                          controller.signUp(
                            emailAddress: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            userName: nameController.text,
                          );
                        }
                      },
                      width: 1.sw,
                      child: Text(
                        "Sign Up",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 16.sp,
                                  color: AppConstant.appWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "OR",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.black.withOpacity(1),
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        AppConstant.showLoader(context: context);
                        controller.googleSignUp();
                      },
                      child: Container(
                        height: 40.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: AppConstant.subtitleColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            15.r,
                          ),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              googleImage,
                              height: 30.h,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              "SignUp with google",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: GestureDetector(
                        child: Text.rich(
                          TextSpan(
                            text: "Have a account?  ",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                ),
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: AppConstant.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Get.toNamed(
                                      Routes.SIGN_IN,
                                    );
                                  },
                              ),
                            ],
                          ),
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
      ),
    );
  }
}
