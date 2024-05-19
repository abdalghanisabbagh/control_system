import 'package:control_system/domain/controllers/SeatingNumbersControllers/CreateCoversSheetsController.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeatingScreen extends GetView<CreateCoversSheetsController> {
  const SeatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Seat Numbers ",
                  style: nunitoBoldStyle()
                      .copyWith(fontSize: 30, color: ColorManager.bgSideMenu),
                ),
              ),
            ),
          ],
        ),
        //const HeaderCoverWidget(text: "Seats number"),
        const SizedBox(
          height: 20,
        ),

        //   Obx(() => controller.creatMissionController.yearList.isEmpty
        //       ? const Center(
        //           child: CircularProgressIndicator(),
        //         )
        //       : DropdownSearch<YearsResponse>(
        //           items: controller.creatMissionController.yearList,
        //           itemAsString: (item) => item.year,
        //           selectedItem:
        //               controller.creatMissionController.selectedyear != null
        //                   ? controller.creatMissionController.selectedyear!.value
        //                   : null,
        //           dropdownDecoratorProps: DropDownDecoratorProps(
        //             dropdownSearchDecoration: InputDecoration(
        //                 focusedBorder: OutlineInputBorder(
        //                     borderSide:
        //                         BorderSide(color: ColorManager.glodenColor),
        //                     borderRadius: BorderRadius.circular(10)),
        //                 border: OutlineInputBorder(
        //                     borderSide:
        //                         BorderSide(color: ColorManager.glodenColor),
        //                     borderRadius: BorderRadius.circular(10)),
        //                 hintText: "Select Education Years",
        //                 hintStyle: nunitoBoldStyle().copyWith(
        //                     fontSize: 30, color: ColorManager.bgSideMenu)),
        //           ),
        //           onChanged: ((value) {
        //             controller.selectedyear = value;
        //             controller.onChangeYear(value!);
        //           }),
        //         )),
        //   const SizedBox(
        //     height: 20,
        //   ),
        //   /////
        //   /*
        //   GetBuilder<CreateCoversSheetsController>(
        //       builder: (c) => controller.selectedyear == null
        //           ? const SizedBox.shrink()
        //           : Obx(
        //               () => controller.missionsController.missionsLoader.value
        //                   ? const Expanded(
        //                       child: Center(
        //                         child: CircularProgressIndicator(),
        //                       ),
        //                     )
        //                   : controller.missionsController.missions.isEmpty
        //                       ? const Center(
        //                           child: Text("No Missions"),
        //                         )
        //                       : Row(
        //                           children: [
        //                             Expanded(
        //                               child:
        //                                   DropdownSearch<MissionObjectResponse>(
        //                                 popupProps: PopupProps.menu(
        //                                   searchFieldProps: TextFieldProps(
        //                                       decoration: InputDecoration(
        //                                           hintText: "search",
        //                                           hintStyle: AppTextStyle
        //                                               .nunitoRegular
        //                                               .copyWith(
        //                                                   fontSize: 16,
        //                                                   color: ColorManager.black),
        //                                           focusedBorder: OutlineInputBorder(
        //                                               borderSide: BorderSide(
        //                                                   color: ColorManager.black),
        //                                               borderRadius:
        //                                                   BorderRadius.circular(
        //                                                       10)),
        //                                           enabledBorder: OutlineInputBorder(
        //                                               borderSide: BorderSide(
        //                                                   color: ColorManager.black),
        //                                               borderRadius:
        //                                                   BorderRadius.circular(
        //                                                       10))),
        //                                       cursorColor: ColorManager.glodenColor),
        //                                   showSearchBox: true,
        //                                 ),
        //                                 items: controller
        //                                     .missionsController.missions,
        //                                 itemAsString: (item) => item.name!,
        //                                 dropdownDecoratorProps:
        //                                     DropDownDecoratorProps(
        //                                   dropdownSearchDecoration:
        //                                       InputDecoration(
        //                                           focusedBorder:
        //                                               OutlineInputBorder(
        //                                                   borderSide: BorderSide(
        //                                                       color:
        //                                                           ColorManager.black),
        //                                                   borderRadius:
        //                                                       BorderRadius
        //                                                           .circular(10)),
        //                                           border: OutlineInputBorder(
        //                                               borderSide: BorderSide(
        //                                                   color: ColorManager.black),
        //                                               borderRadius:
        //                                                   BorderRadius.circular(
        //                                                       10)),
        //                                           hintText: "Select Mission",
        //                                           hintStyle: AppTextStyle
        //                                               .nunitoRegular
        //                                               .copyWith(
        //                                                   fontSize: 16,
        //                                                   color: ColorManager.black)),
        //                                 ),
        //                                 onChanged: ((value) {
        //                                   controller.onChangeMission(value!);
        //                                 }),
        //                                 selectedItem:
        //                                     controller.selectedMission == null
        //                                         ? null
        //                                         : controller
        //                                             .selectedMission!.value,
        //                               ),
        //                             ),
        //                             TextButton(
        //                                 onPressed: () {
        //                                   controller.selectedGrade = null;
        //                                   controller.selectedSubject = null;
        //                                   controller.startFilter();
        //                                 },
        //                                 child: const Text("Reset Filters"))
        //                           ],
        //                         ),
        //             )),
        // */
        //   const SizedBox(
        //     height: 10,
        //   ),
        //   Obx(
        //     () => controller.missionsController.missions.isEmpty
        //         ? const SizedBox.shrink()
        //         : DropdownSearch<MissionObjectResponse>(
        //             popupProps: PopupProps.menu(
        //               searchFieldProps: TextFieldProps(
        //                   decoration: InputDecoration(
        //                       hintText: "search",
        //                       hintStyle: nunitoBoldStyle().copyWith(
        //                           fontSize: 30, color: ColorManager.bgSideMenu),
        //                       focusedBorder: OutlineInputBorder(
        //                           borderSide:
        //                               BorderSide(color: ColorManager.black),
        //                           borderRadius: BorderRadius.circular(10)),
        //                       enabledBorder: OutlineInputBorder(
        //                           borderSide:
        //                               BorderSide(color: ColorManager.black),
        //                           borderRadius: BorderRadius.circular(10))),
        //                   cursorColor: ColorManager.glodenColor),
        //               showSearchBox: true,
        //             ),
        //             items: controller.missionsController.missions,
        //             itemAsString: (item) => item.name!,
        //             dropdownDecoratorProps: DropDownDecoratorProps(
        //               dropdownSearchDecoration: InputDecoration(
        //                   focusedBorder: OutlineInputBorder(
        //                       borderSide: BorderSide(color: ColorManager.black),
        //                       borderRadius: BorderRadius.circular(10)),
        //                   border: OutlineInputBorder(
        //                       borderSide: BorderSide(color: ColorManager.black),
        //                       borderRadius: BorderRadius.circular(10)),
        //                   hintText: "Select Mission",
        //                   hintStyle: nunitoBoldStyle().copyWith(
        //                       fontSize: 30, color: ColorManager.bgSideMenu)),
        //             ),
        //             onChanged: ((value) {
        //               controller.selectMission = value;

        //               controller.isLoading.value = false;
        //             }),
        //             selectedItem: controller.selectedMission == null
        //                 ? null
        //                 : controller.selectedMission!.value,
        //           ),
        //   ),

        //   const SizedBox(
        //     height: 20,
        //   ),
        //   Obx(
        //     () => controller.missionsController.missions.isEmpty
        //         ? const SizedBox.shrink()
        //         : controller.gradeController.grades.isEmpty
        //             ? const CircularProgressIndicator()
        //             : DropdownSearch<GradeResponse>(
        //                 popupProps: PopupProps.menu(
        //                   searchFieldProps: TextFieldProps(
        //                       decoration: InputDecoration(
        //                           hintText: "search",
        //                           hintStyle: nunitoBoldStyle().copyWith(
        //                               fontSize: 30,
        //                               color: ColorManager.bgSideMenu),
        //                           focusedBorder: OutlineInputBorder(
        //                               borderSide:
        //                                   BorderSide(color: ColorManager.black),
        //                               borderRadius: BorderRadius.circular(10)),
        //                           enabledBorder: OutlineInputBorder(
        //                               borderSide:
        //                                   BorderSide(color: ColorManager.black),
        //                               borderRadius: BorderRadius.circular(10))),
        //                       cursorColor: ColorManager.glodenColor),
        //                   showSearchBox: true,
        //                 ),
        //                 items: controller.gradeController.grades,
        //                 itemAsString: (item) => item.name,
        //                 dropdownDecoratorProps: DropDownDecoratorProps(
        //                   dropdownSearchDecoration: InputDecoration(
        //                       focusedBorder: OutlineInputBorder(
        //                           borderSide:
        //                               BorderSide(color: ColorManager.black),
        //                           borderRadius: BorderRadius.circular(10)),
        //                       border: OutlineInputBorder(
        //                           borderSide:
        //                               BorderSide(color: ColorManager.black),
        //                           borderRadius: BorderRadius.circular(10)),
        //                       hintText: "Select Grade",
        //                       hintStyle: nunitoBoldStyle().copyWith(
        //                           fontSize: 30, color: ColorManager.bgSideMenu)),
        //                 ),
        //                 onChanged: ((value) {
        //                   controller.selectedGrade = value;
        //                 }),
        //                 selectedItem: controller.selectedGrade,
        //               ),
        //   ),
        //   const SizedBox(
        //     height: 20,
        //   ),
        //   Obx(
        //     () => controller.missionsController.missions.isEmpty
        //         ? const Center(
        //             child: Text("No Data"),
        //           )
        //         : controller.isLoading.value
        //             ? const Center(
        //                 child: CircularProgressIndicator(),
        //               )
        //             : controller.selectMission == null
        //                 ? const Center(
        //                     child: Text("Select Mission"),
        //                   )
        //                 : Expanded(
        //                     child: ListView.builder(
        //                       shrinkWrap: true,
        //                       itemCount: 1,
        //                       itemBuilder: (context, index) {
        //                         return Container(
        //                             decoration: BoxDecoration(
        //                                 boxShadow: [
        //                                   BoxShadow(
        //                                     color: Colors.grey.withOpacity(0.5),
        //                                     spreadRadius: 5,
        //                                     blurRadius: 20,
        //                                     offset: const Offset(2,
        //                                         15), // changes position of shadow
        //                                   ),
        //                                 ],
        //                                 color: ColorManager.ligthBlue,
        //                                 borderRadius: BorderRadius.circular(11)),
        //                             margin: const EdgeInsets.symmetric(
        //                                 horizontal: 30, vertical: 20),
        //                             width: double.infinity,
        //                             child: bdg.Badge(
        //                               padding: const EdgeInsets.all(10),
        //                               badgeColor: ColorManager.red,
        //                               badgeContent: IconButton(
        //                                 onPressed: () {
        //                                   showGeneralDialog(
        //                                       context: context,
        //                                       pageBuilder: (ctx, a1, a2) {
        //                                         return Container();
        //                                       },
        //                                       transitionBuilder:
        //                                           (ctx, a1, a2, child) {
        //                                         var curve = Curves.easeInOut
        //                                             .transform(a1.value);

        //                                         return DeleteMissionDialog(
        //                                             curve: curve);
        //                                       });
        //                                 },
        //                                 icon: Icon(
        //                                   Icons.delete_forever,
        //                                   color: ColorManager.white,
        //                                 ),
        //                               ),
        //                               child: Column(
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   Padding(
        //                                     padding: const EdgeInsets.all(20),
        //                                     child: Column(
        //                                       crossAxisAlignment:
        //                                           CrossAxisAlignment.start,
        //                                       children: [
        //                                         Text(
        //                                           "Mission name : ${controller.selectMission!.name}",
        //                                           style: nunitoBoldStyle()
        //                                               .copyWith(
        //                                                   fontSize: 30,
        //                                                   color: ColorManager
        //                                                       .bgSideMenu),
        //                                         ),
        //                                         const SizedBox(
        //                                           height: 20,
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                   InkWell(
        //                                     onTap: () {
        //                                       if (controller.selectedGrade !=
        //                                           null) {
        //                                         controller.generateSeatsNumber();
        //                                       } else {
        //                                         MyReusbleWidget.mySnackBarError(
        //                                             "Seat Number",
        //                                             "please select grade");
        //                                       }
        //                                     },
        //                                     child: Container(
        //                                       height: 50,
        //                                       width: double.infinity,
        //                                       decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             const BorderRadius.only(
        //                                                 bottomLeft:
        //                                                     Radius.circular(10),
        //                                                 bottomRight:
        //                                                     Radius.circular(10)),
        //                                         color: ColorManager.bgSideMenu,
        //                                       ),
        //                                       child: Row(
        //                                         mainAxisAlignment:
        //                                             MainAxisAlignment.center,
        //                                         children: [
        //                                           Text(
        //                                             "Generate PDF",
        //                                             style: nunitoBoldStyle()
        //                                                 .copyWith(
        //                                                     fontSize: 30,
        //                                                     color: ColorManager
        //                                                         .bgSideMenu),
        //                                           ),
        //                                           const SizedBox(
        //                                             width: 20,
        //                                           ),
        //                                           Icon(
        //                                             Icons.print,
        //                                             color: ColorManager.white,
        //                                           )
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ));
        //                       },
        //                     ),
        //                   ),
        //   )
      ],
    );
  }
}
