import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../index.dart';

class MytextFormFiled extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final int maxlines;
  final bool? isEnable;
  final String? Function(String? newValue)? myValidation;
  final bool? isNumber;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? textInputs;
  final String? Function(String? value)? onChange;
  final bool obscureText;
  final Color? enableBorderColor;
  final Color? foucsBorderColor;

  const MytextFormFiled(
      {super.key,
      this.title,
      required this.controller,
      this.maxlines = 1,
      this.isEnable,
      this.myValidation,
      this.isNumber,
      this.textInputs,
      this.onChange,
      this.suffixIcon,
      this.obscureText = false,
      this.enableBorderColor = ColorManager.grey,
      this.foucsBorderColor = ColorManager.primary});

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
      enabled: isEnable,
      validator: myValidation,
      onChanged: onChange,
      obscureText: obscureText,
    ).paddingOnly(
      top: AppPading.p25,
    );
  }
}
