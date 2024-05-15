import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MytextFormFiled extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final int maxlines;
  final bool? isEnable;
  final String? Function(String? newValue)? myValidation;
  final bool? isPrice;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? textInputs;
  final String? Function(String? value)? onChange;
  final bool obscureText; // إضافة وسيطة للتحكم في إخفاء النص
  const MytextFormFiled({
    super.key,
    this.title,
    required this.controller,
    this.maxlines = 1,
    this.isEnable,
    this.myValidation,
    this.isPrice,
    this.textInputs,
    this.onChange,
    this.suffixIcon,
    this.obscureText = false, // تعيين قيمة افتراضية لوسيطة الإخفاء
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isPrice != null ? TextInputType.number : null,
      inputFormatters: textInputs ?? [],
      style: nunitoRegulerStyle(
        fontSize: FontSize.s12,
        color: ColorManager.black,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: title,
        labelStyle: nunitoRegulerStyle(
          fontSize: FontSize.s12,
          color: ColorManager.black,
        ),
        hintText: title,
        hintStyle: nunitoRegulerStyle(
          fontSize: FontSize.s12,
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
