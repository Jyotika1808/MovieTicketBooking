import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnotherUserInputField extends StatelessWidget {
  const AnotherUserInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.isNameField = false,
    this.textInputType = TextInputType.name,
    this.textInputAction = TextInputAction.done,
    this.readOnly,
  });
  final TextEditingController controller;
  final String hintText;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final bool? isNameField;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      readOnly: readOnly ?? false,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 15.sp,
            color: Colors.black,
          ),
      textCapitalization: isNameField == true
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      keyboardType: textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      decoration: InputDecoration(
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
        hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
        hintText: hintText,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }
}
