import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

class AddSubjectWidget extends StatelessWidget {
  const AddSubjectWidget({
    super.key,
    required this.onPressed,
  });

  final Future<dynamic> Function({required String name}) onPressed;

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectNameController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Add New Subject",
          style: nunitoRegular.copyWith(
            color: ColorManager.bgSideMenu,
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // GetBuilder<SubjectsControllers>(
        //   builder: (subjectsControllers) =>
        //       Container(
        //     height: 55,
        //     decoration: BoxDecoration(
        //       color: ColorManager.bgColor,
        //       borderRadius:
        //           const BorderRadius.all(
        //               Radius.circular(15)),
        //       border: Border.all(),
        //     ),
        //     child: DropdownButton<
        //         SubjectCategoryResponse>(
        //       style:                                           nunitoRegular
        //           .copyWith(
        //               color: ColorManager
        //                   .bgSideMenu),
        //       value: subjectsControllers
        //           .selectedCategory,
        //       borderRadius:
        //           BorderRadius.circular(10),
        //       isExpanded: true,
        //       underline: Container(),
        //       hint: Padding(
        //         padding: const EdgeInsets
        //             .symmetric(
        //             horizontal: 20),
        //         child: Text('Select Category',
        //             style:                                                 .nunitoBold
        //                 .copyWith(
        //               color:
        //                   ColorManager.bgSideMenu,
        //               fontSize: 14,
        //             )),
        //       ),
        //       icon: Container(
        //         height: 55,
        //         decoration:
        //             const BoxDecoration(
        //           border: Border(
        //             left: BorderSide(),
        //           ),
        //         ),
        //         child: Icon(
        //             Icons
        //                 .keyboard_arrow_down_rounded,
        //             color:
        //                 ColorManager.bgSideMenu),
        //       ),
        //       items: controller
        //           .category.subjects
        //           .map<
        //                   DropdownMenuItem<
        //                       SubjectCategoryResponse>>(
        //               (SubjectCategoryResponse
        //                   value) {
        //         return DropdownMenuItem<
        //             SubjectCategoryResponse>(
        //           value: value,
        //           child: Padding(
        //             padding: const EdgeInsets
        //                 .symmetric(
        //                 horizontal: 20),
        //             child: Text(
        //               value.name,
        //               maxLines: 1,
        //               overflow: TextOverflow
        //                   .ellipsis,
        //               softWrap: true,
        //               style:nunitoSemiBold
        //                   .copyWith(
        //                       fontSize: 12,
        //                       color: ColorManager
        //                           .bgSideMenu,),
        //             ),
        //           ),
        //         );
        //       }).toList(),
        //       onChanged: (newOne) async {
        //         subjectsControllers
        //                 .selectedCategory =
        //             newOne;
        //         subjectsControllers.update();
        //       },
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        // TextFormField(
        //   cursorColor: ColorManager.bgSideMenu,
        //   style: nunitoRegular.copyWith(
        //       fontSize: 14, color: ColorManager.bgSideMenu),
        //   decoration: InputDecoration(
        //     hintText: "Title",
        //     hintStyle: nunitoRegular.copyWith(
        //         fontSize: 14, color: ColorManager.bgSideMenu),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //     errorBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //     disabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //   ),
        //   controller: subjectTitleController,
        //   // onChanged: (value) {
        //   //   int found = controller.subjects
        //   //       .indexWhere(
        //   //     (p0) => p0.name == value,
        //   //   );
        //   //   if (found > -1) {
        //   //     log('founded');
        //   //   }
        //   // },
        // ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          cursorColor: ColorManager.bgSideMenu,
          style: nunitoRegular.copyWith(
              fontSize: 14, color: ColorManager.bgSideMenu),
          decoration: InputDecoration(
            hintText: "Subject name",
            hintStyle: nunitoRegular.copyWith(
                fontSize: 14, color: ColorManager.bgSideMenu),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          controller: subjectNameController,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "InExam  ",
              style: nunitoRegular.copyWith(
                  fontSize: 14, color: ColorManager.bgSideMenu),
            ),
            // Obx(
            //   () => Checkbox(
            //     value: inExam.value,
            //     onChanged: (newVal) {
            //       inExam.value = newVal!;
            //     },
            //   ),
            // )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Expanded(
              child: ElevatedBackButton(),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedAddButton(
                onPressed: () async {
                  await onPressed(name: subjectNameController.text).then(
                    (value) {
                      value
                          ? {
                              context.pop(),
                              MyFlashBar.showSuccess(
                                      'The Subject Has Been Added Successfully',
                                      'Success')
                                  .show(context)
                            }
                          : null;
                    },
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
