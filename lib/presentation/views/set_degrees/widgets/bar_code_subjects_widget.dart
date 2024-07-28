import 'package:flutter/material.dart';

import '../../../resource_manager/index.dart';

class BarCodeSubjects extends StatelessWidget {
  const BarCodeSubjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Name : ',
                  style: nunitoBlack.copyWith(
                      color: ColorManager.bgSideMenu, fontSize: 16),
                  children: const <TextSpan>[
                    // TextSpan(
                    //   text:
                    //       "${controller.stdExBRCResMod!.students!.firstName} ${controller.stdExBRCResMod!.students!.middleName} ${controller.stdExBRCResMod!.students!.lastName}",
                    //   style: nunitoBold.copyWith(
                    //       color: ColorManager.bgSideMenu, fontSize: 16),
                    // ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Grade : ',
                  style: nunitoBlack.copyWith(
                      color: ColorManager.bgSideMenu, fontSize: 16),
                  children: const <TextSpan>[],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Class : ',
                  style: nunitoBlack.copyWith(
                      color: ColorManager.bgSideMenu, fontSize: 16),
                  children: const <TextSpan>[],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          // child: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text(
          //       controller.stdExBRCResMod!.exammission!.subjects!.subjectName,
          //       style: nunitoBold.copyWith(
          //           fontSize: 25, color: ColorManager.bgSideMenu),
          //     ),
          //     controller.stdExBRCResMod!.studentDegree != null
          //         ? Text(
          //             " ${controller.stdExBRCResMod!.studentDegree ?? ''}",
          //             style: nunitoRegular.copyWith(
          //                 fontSize: 25,
          //                 color: brCodeController
          //                             .stdExBRCResMod!.studentDegree ==
          //                         ''
          //                     ? Colors.grey
          //                     : int.parse(brCodeController
          //                                 .stdExBRCResMod!.studentDegree!) >=
          //                             (int.parse(controller.stdExBRCResMod!
          //                                     .exammission!.degree!) *
          //                                 .6)
          //                         ? Colors.green
          //                         : ColorManager.red),
          //           )
          //         : SizedBox(
          //             width: 150,
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 20),
          //               child: TextFormField(
          //                 inputFormatters: [
          //                   FilteringTextInputFormatter.digitsOnly
          //                 ],
          //                 cursorColor: ColorManager.bgSideMenu,
          //                 style: nunitoRegular.copyWith(
          //                     fontSize: 14, color: ColorManager.bgSideMenu),
          //                 decoration: InputDecoration(
          //                   focusedBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(5)),
          //                   enabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(5)),
          //                   errorBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(5)),
          //                   disabledBorder: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(5)),
          //                 ),
          //                 focusNode: brCodeController.degreeController,
          //                 controller: brCodeController.degreeTextController,
          //                 onFieldSubmitted: (v) {
          //                   if (v.length > 3) {
          //                     brCodeController.degreeTextController.clear();
          //                     brCodeController.degreeController
          //                         .requestFocus();
          //                   } else {
          //                     brCodeController.updateSubjectGrade(
          //                         brCodeController.degreeTextController.text);
          //                   }
          //                 },
          //               ),
          //             ),
          //           ),
          //     if (brCodeController.stdExBRCResMod != null)
          //       Text(
          //         "  /  ${brCodeController.stdExBRCResMod!.exammission!.degree!}",
          //         style: nunitoRegular.copyWith(
          //             fontSize: 25, color: ColorManager.bgSideMenu),
          //       ),
          //   ],
          // ),
        ),
        const SizedBox(
          height: 30,
        ),
        // if (brCodeController.stdExBRCResMod!.studentDegree != null)
        // InkWell(
        //   onTap: () {
        //     brCodeController.editStudentGrades();
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: Container(
        //       height: 55,
        //       width: 300,
        //       decoration: BoxDecoration(
        //           color: ColorManager.bgSideMenu,
        //           borderRadius: BorderRadius.circular(11)),
        //       child: Center(
        //           child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 40),
        //         child: Text("Edit",
        //             style: nunitoRegular.copyWith(
        //               color: ColorManager.white,
        //             )),
        //       )),
        //     ),
        //   ),
        // ),
        // if (controller.stdExBRCResMod!.studentDegree == null)
        // InkWell(
        //   onTap: () {
        //     if (controller.degreeTextController.text != "" ||
        //         controller.degreeTextController.text.isNotEmpty) {
        //       controller
        //           .updateSubjectGrade(controller.degreeTextController.text);
        //     } else {
        //       MyReusbleWidget.mySnackBarError(
        //           "student grades", "please set grades");
        //     }
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: Container(
        //       height: 55,
        //       width: 300,
        //       decoration: BoxDecoration(
        //           color: ColorManager.bgSideMenu,
        //           borderRadius: BorderRadius.circular(11)),
        //       child: Center(
        //           child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 40),
        //         child: Text("Done",
        //             style: nunitoRegular.copyWith(
        //               color: ColorManager.white,
        //             )),
        //       )),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
