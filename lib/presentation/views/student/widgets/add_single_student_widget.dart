import 'package:control_system/domain/controllers/studentsController/addNewStudentController.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
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
                if (controller.isLoadingGrades) {
                  return const CircularProgressIndicator();
                }

                if (controller.options.isEmpty) {
                  return const Text('No items available');
                }

                return SizedBox(
                  width: 500,
                  child: MultiSelectDropDownView(
                    onOptionSelected: (selectedItem) {
                      // controller.setSelectedItem(selectedItem[0]);
                    },
                    options: controller.options,
                  ),
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

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: blbIdController,
              decoration: InputDecoration(
                label: Text(
                  "BLB ID",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: fnameController,
              decoration: InputDecoration(
                label: Text(
                  "First Name",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: mnameController,
              decoration: InputDecoration(
                label: Text(
                  "Middle Name",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: lnameController,
              decoration: InputDecoration(
                label: Text(
                  "last Name",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: religionController,
              decoration: InputDecoration(
                label: Text(
                  "Religion field",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: citizenshipController,
              decoration: InputDecoration(
                label: Text(
                  "Citizenship",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: sLangController,
              decoration: InputDecoration(
                label: Text(
                  "Second Language",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            InkWell(
              // onTap: () {
              //   //TODO  add singl student to server

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
