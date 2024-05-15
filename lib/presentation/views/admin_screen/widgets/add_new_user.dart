import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/resource_manager/validations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddNewUserWidget extends StatelessWidget {
  AddNewUserWidget({
    super.key,
  });

  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController nisId = TextEditingController();
  final TextEditingController egyptionId = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController userNameId = TextEditingController();
  final TextEditingController passwordId = TextEditingController();
  final TextEditingController confirmPasswordId = TextEditingController();
  String? roleType;
  String? selectedDivision;

  List<String> schoolDivision = [
    "Elementary",
    "Middle",
    "High",
    "Key Stage 1",
    "Key Stage 2",
    "Key Stage 3",
    "IGCSE",
  ];
  List<String> roleTypes = [
    'Control admin',
    'School Director',
    'Academic Dean',
    'Principal',
    'QR Reader',
    "Vice Principal"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.75,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  DropdownSearch<String>(
                    selectedItem: roleType,
                    items: roleTypes,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.bgSideMenu),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.bgSideMenu),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.bgSideMenu,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.bgSideMenu,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Select Role",
                          hintStyle: nunitoRegularStyle(
                              fontSize: 16, color: ColorManager.bgSideMenu)),
                    ),
                    onChanged: ((value) {
                      roleType = value;

                      /// TODO: Update Screen
                    }),
                  ),
                  if (roleType == roleTypes[3] || roleType == roleTypes[5])
                    DropdownSearch<String>(
                      selectedItem: selectedDivision,
                      items: schoolDivision,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorManager.bgSideMenu),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.bgSideMenu),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.bgSideMenu,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorManager.bgSideMenu,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Select Division",
                            hintStyle: nunitoRegularStyle(
                                fontSize: 16, color: ColorManager.bgSideMenu)),
                      ),
                      onChanged: ((value) {
                        selectedDivision = value;

                        /// TODO: Update Screen
                      }),
                    ),
                  MytextFormFiled(
                    controller: nisId,
                    title: 'NIS ID',
                    myValidation: Validations.requiredValidator,
                  ),
                  // MytextFormFiled(
                  //   controller: egyptionId,
                  //   title: 'Egyptian ID',
                  //   myValidation: Validations.requiredValidator,
                  // ),
                  MytextFormFiled(
                    controller: egyptionId,
                    title: 'Egyptian ID',
                    myValidation: Validations.requiredValidator,
                  ),
                  MytextFormFiled(
                    controller: fullName,
                    title: 'Full Name',
                    myValidation: Validations.requiredValidator,
                  ),
                  MytextFormFiled(
                    controller: userNameId,
                    title: 'User name',
                    myValidation: Validations.requiredValidator,
                  ),
                  MytextFormFiled(
                    controller: passwordId,
                    title: 'Password',
                    myValidation: Validations.requiredValidator,
                  ),
                  MytextFormFiled(
                    controller: confirmPasswordId,
                    title: 'Confirm Password',
                    myValidation: Validations.requiredValidator,
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorManager.bgSideMenu,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(
                    child: Text(
                      "Back",
                      style: nunitoRegularStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  if (formkey.currentState!.validate() || roleType != null) {
                    ///TODO :: Create Method
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: ColorManager.glodenColor,
                      borderRadius: BorderRadius.circular(11)),
                  child: Center(
                    child: Text(
                      "Add",
                      style: nunitoRegularStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
