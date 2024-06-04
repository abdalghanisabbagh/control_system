import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/controllers/SeatingNumbersControllers/CreateCoversSheetsController.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/index.dart';

class AddNewCoverWidget extends GetView<CreateCoversSheetsController> {
  const AddNewCoverWidget({super.key});

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: controller.selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      controller.selectedDate = picked;
    }
    controller.dateController.text =
        DateFormat('dd MMMM yyyy').format(controller.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: IconButton(
                    alignment: AlignmentDirectional.topEnd,
                    color: Colors.black,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GetBuilder<CreateCoversSheetsController>(
                        builder: (controller) {
                          if (controller.isLoadingGetEducationYear) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (controller.options.isEmpty) {
                            return const Text('No items available');
                          }

                          return SizedBox(
                            width: 500,
                            child: MultiSelectDropDownView(
                              hintText: "Select Education Year",
                              onOptionSelected: (selectedItem) {
                                //  controller.setSelectedItem(selectedItem[0]);
                              },
                              showChipSelect: true,
                              options: controller.options,
                            ),
                          );
                        },
                      ),
//// select Education Year
                      // Obx(() => controller
                      //         .creatMissionController.yearList.isEmpty
                      //     ? const Center(
                      //         child: CircularProgressIndicator(),
                      //       )
                      //     : DropdownSearch<YearsResponse>(
                      //         items: controller.creatMissionController.yearList,
                      //         itemAsString: (item) => item.year,
                      //         selectedItem: controller.creatMissionController
                      //                     .selectedyear !=
                      //                 null
                      //             ? controller.creatMissionController
                      //                 .selectedyear!.value
                      //             : null,
                      //         dropdownDecoratorProps: DropDownDecoratorProps(
                      //           dropdownSearchDecoration: InputDecoration(
                      //               focusedBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                       color: ColorManager.glodenColor),
                      //                   borderRadius:
                      //                       BorderRadius.circular(10)),
                      //               border: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                       color: ColorManager.glodenColor),
                      //                   borderRadius:
                      //                       BorderRadius.circular(10)),
                      //               hintText: "Select Education Years",
                      //               hintStyle: nunitoBoldStyle().copyWith(
                      //                   fontSize: 30,
                      //                   color: ColorManager.bgSideMenu)),
                      //         ),
                      //         onChanged: ((value) {
                      //           controller.selectedyear = value;
                      //           controller.onChangeYear(value!);
                      //         }),
                      //       )),

                      const SizedBox(
                        height: 20,
                      ),
                      // mission

                      // Obx(
                      //   () => controller.missionsController.missions.isEmpty
                      //       ? const Center(
                      //           child: CircularProgressIndicator(),
                      //         )
                      //       : DropdownButtonFormField<MissionObjectResponse>(
                      //           value: controller.selectMission,
                      //           decoration: InputDecoration(
                      //               focusedBorder: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.circular(8)),
                      //               enabledBorder: OutlineInputBorder(
                      //                   borderRadius:
                      //                       BorderRadius.circular(8))),
                      //           hint: Text("Select Mission",
                      //               style: AppTextStyle.nunitoRegular.copyWith(
                      //                 color: ColorManager.black,
                      //               )),
                      //           items: controller.missionsController.missions
                      //               .map((MissionObjectResponse selected) {
                      //             return DropdownMenuItem(
                      //                 value: selected,
                      //                 child: Row(
                      //                   children: [
                      //                     Text(selected.name!),
                      //                   ],
                      //                 ));
                      //           }).toList(),
                      //           onChanged: (v) {
                      //             controller.selectMission = v!;
                      //             // controller.getExamRooms(
                      //             //     controller.selectMission!.id!);
                      //           }),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Grades
                      // DropdownButtonFormField<GradeResponse>(
                      //     value: controller.selectedGrade,
                      //     decoration: InputDecoration(
                      //         focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(8)),
                      //         enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(8))),
                      //     hint: Text("Select grade",
                      //         style: nunitoBoldStyle().copyWith(
                      //             fontSize: 30,
                      //             color: ColorManager.bgSideMenu)),
                      //     items: controller.gradeController.grades
                      //         .map((GradeResponse selected) {
                      //       return DropdownMenuItem(
                      //           value: selected,
                      //           child: Row(
                      //             children: [
                      //               Text(selected.name),
                      //             ],
                      //           ));
                      //     }).toList(),
                      //     onChanged: (v) {
                      //       //   controller.selectedGrade = v!;
                      //     }),
                      const SizedBox(
                        height: 20,
                      ),
                      // subject
                      // DropdownButtonFormField<SubjectResponse>(
                      //     value: controller.selectedSubject,
                      //     decoration: InputDecoration(
                      //         focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(8)),
                      //         enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(8))),
                      //     hint: Text("Select subject",
                      //         style: nunitoBoldStyle().copyWith(
                      //             fontSize: 30,
                      //             color: ColorManager.bgSideMenu)),
                      //     items: controller.subjectController.subjects
                      //         .map((SubjectResponse category) {
                      //       return DropdownMenuItem(
                      //           value: category,
                      //           child: Row(
                      //             children: [
                      //               Text(category.name),
                      //             ],
                      //           ));
                      //     }).toList(),
                      //     onChanged: (v) {
                      //       //  controller.selectedSubject = v!;
                      //     }),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Exam Date:', style: nunitoRegularStyle()),
                          const SizedBox(
                            height: 5,
                          ),
                          GetBuilder<CreateCoversSheetsController>(
                              builder: (controller) {
                            return DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                hint: Text("Exam Duration",
                                    style: nunitoRegularStyle()),
                                value:
                                    controller.examTimeController.text.isEmpty
                                        ? null
                                        : int.parse(controller
                                            .examTimeController.text
                                            .split(' ')[0]),
                                items: controller.examDurations
                                    .map((item) => DropdownMenuItem<int>(
                                          value: item,
                                          child: Text(
                                            '$item Mins',
                                            style: nunitoRegularStyle(),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (newValue) {
                                  controller.examTimeController.text =
                                      '$newValue Mins';
                                  controller.update();
                                });
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.bgSideMenu, width: 0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                cursorColor: ColorManager.bgSideMenu,
                                enabled: false,
                                style: nunitoRegularStyle(),
                                controller: controller.dateController,
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.black,
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Example: DD/MM/YYYY',
                                    hintStyle: nunitoRegularStyle()),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.examFinalDegreeController
                          ..text = "100",
                        style: nunitoRegularStyle(),
                        enabled: false,
                        decoration: InputDecoration(
                          label: Text("Exam Final Grade",
                              style: nunitoRegularStyle()),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Exams Versions :", style: nunitoRegularStyle()),
                          GetBuilder<CreateCoversSheetsController>(
                              builder: (controller) {
                            return Row(
                              children: [
                                Text(
                                  '1 Version',
                                  style: TextStyle(
                                      color: !controller.is2Version
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                Switch.adaptive(
                                    value: controller.is2Version,
                                    onChanged: (newValue) {
                                      controller.is2Version = newValue;
                                      controller.update();
                                    }),
                                Text(
                                  '2 Versions',
                                  style: TextStyle(
                                      color: controller.is2Version
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Exams Period :", style: nunitoRegularStyle()),
                          GetBuilder<CreateCoversSheetsController>(
                              builder: (controller) {
                            return Row(
                              children: [
                                Text(
                                  'Session One Exams',
                                  style: TextStyle(
                                      color: !controller.isNight
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                Switch.adaptive(
                                    value: controller.isNight,
                                    onChanged: (newValue) {
                                      controller.isNight = newValue;
                                      controller.update();
                                    }),
                                Text(
                                  'Session Two Exams',
                                  style: TextStyle(
                                      color: controller.isNight
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),

                      InkWell(
                        onTap: () {
                          //      controller.saveCoverSheet();
                        },
                        child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorManager.bgSideMenu,
                                borderRadius: BorderRadius.circular(11)),
                            child: Center(
                              child: Text("Add", style: nunitoSemiBoldStyle()),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
