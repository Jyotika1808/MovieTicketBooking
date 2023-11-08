import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';

class UserInputField extends StatelessWidget {
  UserInputField({
    super.key,
    required this.controller,
    this.icon,
    this.validator,
    required this.hintText,
    this.isNameField = false,
    this.keyboardType = TextInputType.name,
  });

  final TextEditingController controller;
  IconData? icon;
  final String hintText;
  final bool? isNameField;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black.withOpacity(0.4),
          size: 30.sp,
        ),
        SizedBox(
          width: 15.w,
        ),
        Expanded(
          flex: 7,
          child: ClayContainer(
            color: AppConstant.backgroundColor,
            borderRadius: 10.r,
            depth: -150,
            spread: 1.0,
            child: TextFormField(
              controller: controller,
              autofocus: false,
              keyboardType: keyboardType,
              textCapitalization: isNameField == true
                  ? TextCapitalization.sentences
                  : TextCapitalization.none,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 244, 244, 244),
                filled: true,
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
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
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }
}
