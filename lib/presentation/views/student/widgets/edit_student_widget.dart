import 'package:control_system/Data/Models/student/student_res_model.dart';
import 'package:control_system/domain/controllers/studentsController/student_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/resource_manager/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStudentWidget extends GetView<StudentController> {
  EditStudentWidget({
    super.key,
    required this.studentResModel,
  });

  final StudentResModel studentResModel;

  final TextEditingController blbIdController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController sLangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // fnameController.text =
    //     controller.rows[studentIndex].cells['FirstName']!.value;
    // mnameController.text =
    //     controller.rows[studentIndex].cells['MiddleName']!.value;
    // lnameController.text =
    //     controller.rows[studentIndex].cells['LastName']!.value;
    // religionController.text =
    //     controller.rows[studentIndex].cells['Religion_field']!.value;
    // citizenshipController.text =
    //     controller.rows[studentIndex].cells['Citizenship_field']!.value;
    // sLangController.text =
    //     controller.rows[studentIndex].cells['Language_field']!.value;
    // selectedGrade = StudentServices.getGrade(
    //     name: controller.rows[studentIndex].cells['Grade_field']!.value);
    // selectedClass = classesControllers.classesRooms.firstWhere((room) =>
    //     room.className ==
    //     controller.rows[studentIndex].cells['ClassRoom_field']!.value!);
    // selectedCohort = StudentServices.getCohort(
    //     name: controller.rows[studentIndex].cells['cohort']!.value);

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
              "Edit student",
              style: nunitoBold.copyWith(
                color: ColorManager.primary,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<StudentController>(
              builder: (controller) {
                if (controller.loading) {
                  return const CircularProgressIndicator();
                }

                if (controller.optionsCohort.isEmpty) {
                  return const Text('No items available');
                }

                return SizedBox(
                  width: 500,
                  child: MultiSelectDropDownView(
                    onOptionSelected: (selectedItem) {
                      //    controller.setSelectedItem(selectedItem[0]);
                    },
                    options: controller.optionsCohort,
                    optionSelected: [
                      controller.optionsCohort.firstWhere((element) =>
                          element.value == studentResModel.cohortID),
                    ],
                  ),
                );
              },
            ),
            // DropdownButtonFormField<GradeResponse>(
            //   value: selectedGrade,
            //   decoration: InputDecoration(
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            //   hint: Text(
            //     "Select grade",
            //     style: nunitoRegular.copyWith(
            //       color: ColorManager.black,
            //     ),
            //   ),
            //   items: gradesControllers.grades.map(
            //     (GradeResponse selected) {
            //       return DropdownMenuItem(
            //         value: selected,
            //         child: Row(
            //           children: [
            //             Text(selected.name),
            //           ],
            //         ),
            //       );
            //     },
            //   ).toList(),
            //   onChanged: (v) {
            //     selectedGrade = v!;
            //   },
            // ),

            const SizedBox(
              height: 20,
            ),
            // Obx(
            //   () => classesControllers.classesRooms.isEmpty
            //       ? Text("Loading ....",
            //           style: nunitoBold.copyWith(
            //             color: ColorManager.black,
            //           ))
            //       : DropdownButtonFormField<ClassResponse>(
            //           value: selectedClass,
            //           decoration: InputDecoration(
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(8),
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(8),
            //             ),
            //           ),
            //           hint: Text("Select Class Room",
            //               style: nunitoRegular.copyWith(
            //                 color: ColorManager.black,
            //               )),
            //           items: classesControllers.classesRooms.map(
            //             (ClassResponse selected) {
            //               return DropdownMenuItem(
            //                 value: selected,
            //                 child: Row(
            //                   children: [
            //                     Text(
            //                         "${selected.className} / ${selected.floorName} / ${selected.buildName} / "),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ).toList(),
            //           onChanged: (v) {
            //             selectedClass = v!;
            //           },
            //         ),
            // ),
            const SizedBox(
              height: 10,
            ),
            // cohort
            // Obx(
            //   () => cohortController.cohorts.isEmpty
            //       ? const Text("Loading ....")
            //       : DropdownButtonFormField<CohortResponse>(
            //           value: selectedCohort,
            //           decoration: InputDecoration(
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(8),
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(8),
            //             ),
            //           ),
            //           hint: Text("Select Cohort",
            //               style: nunitoRegular.copyWith(
            //                 color: ColorManager.black,
            //               )),
            //           items: cohortController.cohorts.map(
            //             (CohortResponse selected) {
            //               return DropdownMenuItem(
            //                 value: selected,
            //                 child: Row(
            //                   children: [
            //                     Text(selected.name),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ).toList(),
            //           onChanged: (v) {
            //             selectedCohort = v!;
            //           },
            //         ),
            // ),

            const SizedBox(
              height: 20,
            ),

            MytextFormFiled(
                controller: fnameController
                  ..text = studentResModel.firstName.toString(),
                title: "First Name",
                myValidation: Validations.requiredValidator),

            MytextFormFiled(
                controller: mnameController
                  ..text = studentResModel.secondName.toString(),
                title: "Middle Name",
                myValidation: Validations.requiredValidator),

            MytextFormFiled(
                controller: lnameController
                  ..text = studentResModel.thirdName.toString(),
                title: "Last Name",
                myValidation: Validations.requiredValidator),

            MytextFormFiled(
                controller: religionController,
                title: "Religion",
                myValidation: Validations.requiredValidator),
            MytextFormFiled(
                controller: citizenshipController,
                title: "Citizenship",
                myValidation: Validations.requiredValidator),
            MytextFormFiled(
                controller: sLangController
                  ..text = studentResModel.secondLang.toString(),
                title: "Second Language",
                myValidation: Validations.requiredValidator),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              // onTap: () async {
              //   StudentRequest student = StudentRequest(
              //       blbId: controller.rows[studentIndex].cells['Id']!.value,
              //       lastName: lnameController.text,
              //       firstName: fnameController.text,
              //       middlName: mnameController.text,
              //       secondLanguage: sLangController.text,
              //       religion: religionController.text);

              //   await controller.updateStudent(student, studentIndex);
              // },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorManager.bgSideMenu,
                    borderRadius: BorderRadius.circular(11)),
                child: Center(
                  child: Text(
                    "Update",
                    style: nunitoRegular.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
