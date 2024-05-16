import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStudentWidget extends StatelessWidget {
  EditStudentWidget({super.key});

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
                color: ColorManager.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
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

            TextFormField(
              controller: fnameController,
              decoration: InputDecoration(
                label: Text(
                  "FirstName",
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
                  "MiddleName",
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
                  "lastName",
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
                  "Religion",
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
