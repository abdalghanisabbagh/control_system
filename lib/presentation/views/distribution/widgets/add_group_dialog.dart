import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGroupDialog extends StatelessWidget {
  final TextEditingController studentsNumbers = TextEditingController();
  final TextEditingController studentsClass = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddGroupDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // GetBuilder<DistrbutionController>(
        //   builder: (distrbutionController) => Column(
        //     children: [
        //       DropdownSearch<GradeResponse>(
        //         items: controller.newGrades!,
        //         selectedItem: controller.selectedGrade,
        //         itemAsString: (item) =>
        //             "${item.name} ( Students : ${item.studentseatnumbers!.length.toString()} )",
        //         dropdownDecoratorProps: DropDownDecoratorProps(
        //           dropdownSearchDecoration: InputDecoration(
        //             focusedBorder: OutlineInputBorder(
        //               borderSide: BorderSide(color: ColorManager.glodenColor),
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //             border: OutlineInputBorder(
        //               borderSide: BorderSide(color: ColorManager.glodenColor),
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //             hintText: "Select Grade",
        //             hintStyle: nunitoRegular.copyWith(
        //               fontSize: 16,
        //               color: ColorManager.black,
        //             ),
        //           ),
        //         ),
        //         onChanged: (
        //           (value) {
        //             controller.selectedGrade = value;
        //             controller.update();
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 10,
        ),
        Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: studentsNumbers,
                decoration:
                    const InputDecoration(hintText: "Students' numbers"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: studentsClass,
                decoration: const InputDecoration(
                    hintText: "Students' Class (optional)"),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(11),
                    ),
                    color: ColorManager.bgSideMenu,
                  ),
                  child: Center(
                    child: Text(
                      "Back",
                      style: nunitoRegular.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                // onTap: () {
                //   int maxlenght = 0;
                //   controller.studentsTosets.forEach((key, value) {
                //     maxlenght = maxlenght + value!.length;
                //   });
                //   final diff =
                //       controller.selectedExamRoom!.maxCapacity - maxlenght;

                //   if (diff >= 0) {
                //     if (diff >= int.parse(studentsNumbers.text)) {
                //       // add student of selected grade

                //       List<Studentseatnumber>? sets;
                //       if (studentsClass.text.isNotEmpty) {
                //         var className = StudentServices.getClassResponse(
                //             name: studentsClass.text);
                //         sets = controller.selectedGrade!.studentseatnumbers!
                //             .where((element) =>
                //                 element.students!.classId == className!.id)
                //             .take(int.parse(studentsNumbers.text))
                //             .toList();
                //       } else {
                //         sets = controller.selectedGrade!.studentseatnumbers!
                //             .take(int.parse(studentsNumbers.text))
                //             .toList();
                //       }

                //       controller.studentsTosets
                //           .addAll({controller.selectedGrade!.id: sets});
                //       controller.update();
                //       Get.back();
                //     } else {
                //       MyFlashBar.showError(
                //         "Distrbution",
                //         "max capacity  to insert is : $diff",
                //       );
                //     }
                //   } else {
                //     MyFlashBar.showError(
                //       "Distrbution",
                //       "max capacity in rom is : $diff",
                //     );
                //   }
                // },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(11),
                      ),
                      color: ColorManager.glodenColor),
                  child: Center(
                    child: Text(
                      "Add",
                      style: nunitoRegular.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
