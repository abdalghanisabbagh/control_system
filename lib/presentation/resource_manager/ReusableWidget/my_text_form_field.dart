import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/resource_manager/font_manager.dart';
import 'package:control_system/presentation/resource_manager/styles_manager.dart';
import 'package:control_system/presentation/resource_manager/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppPading.p12.w, vertical: AppPading.p12.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: poppinsMeduimStyle(
                fontSize: FontSize.s12,
                color: ColorManager.darkGrey2,
              ),
            ),
          if (title != null)
            SizedBox(
              height: 5.h,
            ),
          TextFormField(
            keyboardType: isPrice != null ? TextInputType.number : null,
            inputFormatters: textInputs ?? [],
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: title,
              hintStyle: poppinsRegulerStyle(
                fontSize: FontSize.s12,
                color: ColorManager.grey,
              ),
            ),
            controller: controller,
            maxLines: maxlines,
            enabled: isEnable,
            validator: myValidation,
            onChanged: onChange,
          )
        ],
      ),
    );
  }
}
