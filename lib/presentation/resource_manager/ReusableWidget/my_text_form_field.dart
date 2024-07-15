import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../index.dart';

class MytextFormFiled extends StatelessWidget {
  const MytextFormFiled({
    super.key,
    this.title,
    required this.controller,
    this.maxlines = 1,
    this.maxLength,
    this.isEnable,
    this.myValidation,
    this.isNumber,
    this.textInputs,
    this.onChange,
    this.suffixIcon,
    this.obscureText = false,
    this.enableBorderColor = ColorManager.grey,
    this.foucsBorderColor = ColorManager.primary,
    this.onFieldSubmitted,
    this.focusNode,
  });

  final String? Function(String? newValue)? myValidation;
  final String? Function(String? value)? onChange;
  final Function(String? value)? onFieldSubmitted;
  final TextEditingController controller;
  final Color? enableBorderColor;
  final Color? foucsBorderColor;
  final bool? isEnable;
  final bool? isNumber;
  final int maxlines;
  final int? maxLength;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? textInputs;
  final String? title;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isNumber == true ? TextInputType.number : null,
      inputFormatters: isNumber == true
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : [],
      style: nunitoRegularStyle(
        fontSize: FontSize.s18,
        color: ColorManager.primary,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: title,
        labelStyle: nunitoRegularStyle(
          fontSize: FontSize.s12,
          color: ColorManager.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enableBorderColor!, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: foucsBorderColor!, width: 3.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: title,
        hintStyle: nunitoRegularStyle(
          fontSize: FontSize.s16,
          color: ColorManager.grey,
        ),
      ),
      controller: controller,
      maxLines: maxlines,
      maxLength: maxLength,
      enabled: isEnable,
      validator: myValidation,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      focusNode: focusNode,
    ).paddingOnly(
      top: AppPading.p25,
    );
  }
}
