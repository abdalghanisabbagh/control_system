import 'package:control_system/domain/controllers/studentsController/addNewStudentController.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSingleStudentWidget extends GetView<AddNewStudentController> {
  AddSingleStudentWidget({super.key});

  final TextEditingController blbIdController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController sLangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: IconButton(
                alignment: AlignmentDirectional.topEnd,
                color: Colors.black,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Text(
              "Add new student",
              style: nunitoBold.copyWith(
                color: ColorManager.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // grades
            GetBuilder<AddNewStudentController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const CircularProgressIndicator();
                }

                if (controller.optionsGrades.isEmpty) {
                  return const Text('No items available');
                }

                return Column(
                  children: [
                    SizedBox(
                      width: 500,
                      child: MultiSelectDropDownView(
                        hintText: "Select Grade",
                        onOptionSelected: (selectedItem) {},
                        options: controller.optionsGrades,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 500,
                      child: MultiSelectDropDownView(
                        hintText: "Select Cohort",
                        onOptionSelected: (selectedItem) {},
                        options: controller.optionsCohort,
                      ),
                    )
                  ],
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),

            // class
            // Obx(
            //   () => classesControllers.classesRooms.isEmpty
            //       ? Text("Loading ....",
            //           style: nunitoBold.copyWith(
            //             color: ColorManager.black,
            //           ))
            //       : DropdownButtonFormField<ClassResponse>(
            //           value: selectedClass,
            //           decoration: InputDecoration(
            //               focusedBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8)),
            //               enabledBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8))),
            //           hint: Text("Select Class Room",
            //               style: nunitoRegular.copyWith(
            //                 color: ColorManager.black,
            //               )),
            //           items: classesControllers.classesRooms
            //               .map((ClassResponse selected) {
            //             return DropdownMenuItem(
            //                 value: selected,
            //                 child: Row(
            //                   children: [
            //                     Text(
            //                         "${selected.className} / ${selected.floorName} / ${selected.buildName} / "),
            //                   ],
            //                 ));
            //           }).toList(),
            //           onChanged: (v) {
            //             selectedClass = v!;
            //           }),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // cohort
            // Obx(
            //   () => cohortController.cohorts.isEmpty
            //       ? const Text("Loading ....")
            //       : DropdownButtonFormField<CohortResponse>(
            //           value: selectedCohort,
            //           decoration: InputDecoration(
            //               focusedBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8)),
            //               enabledBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8))),
            //           hint: Text("Select Cohort",
            //               style: nunitoRegular.copyWith(
            //                 color: ColorManager.black,
            //               )),
            //           items: cohortController.cohorts
            //               .map((CohortResponse selected) {
            //             return DropdownMenuItem(
            //                 value: selected,
            //                 child: Row(
            //                   children: [
            //                     Text(selected.name),
            //                   ],
            //                 ));
            //           }).toList(),
            //           onChanged: (v) {
            //             selectedCohort = v!;
            //           }),
            // ),

            // const SizedBox(
            //   height: 20,
            // ),
            MytextFormFiled(controller: blbIdController, title: "BLB ID"),

            MytextFormFiled(controller: fnameController, title: "First Name"),

            MytextFormFiled(controller: mnameController, title: "Middle Name"),

            MytextFormFiled(controller: lnameController, title: "last Name"),

            MytextFormFiled(
                controller: religionController, title: "Religion field"),

            MytextFormFiled(
                controller: citizenshipController, title: "Citizenship"),

            MytextFormFiled(
                controller: sLangController, title: "Second Language"),

            const SizedBox(
              height: 20,
            ),

            InkWell(
              // onTap: () {

              //   controller.addSinglStudent(
              //     StudentRequest(
              //       blbId: int.parse(blbIdController.text),
              //       firstName: fnameController.text,
              //       middlName: mnameController.text,
              //       lastName: lnameController.text,
              //       religion: religionController.text,
              //       citizenship: citizenshipController.text,
              //       secondLanguage: sLangController.text,
              //       classId: selectedClass!.id,
              //       gradeId: selectedGrade!.id,
              //       cohertId: selectedCohort!.id,
              //     ),
              //   );
              // },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorManager.bgSideMenu,
                    borderRadius: BorderRadius.circular(11)),
                child: Center(
                  child: Text(
                    "Add",
                    style: nunitoRegular.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
