
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BRCodeController extends GetxController {
//   String atoken = '';
//   SchoolResponse? selectedSchool;
//   EducationResponse? selectedEduction;
//   StudentExamBRCResponseModel? stdExBRCResMod;
//   bool buildwidget = false;
//   bool edit = false;
//   TextEditingController degreeTextController = TextEditingController();

//   final TextEditingController barcodeController = TextEditingController();
//   final FocusNode brCodeFoucs = FocusNode();

//   FocusNode degreeController = FocusNode();
//   RxBool isLoading = false.obs;
  
//   @override
//   void onReady() {
//     super.onReady();
//     brCodeFoucs.requestFocus();
//     atoken = Hive.box('Token').get('token');
//     selectedSchool = SchoolResponse(
//         id: Hive.box('School').get("Id"), name: Hive.box('School').get("Name"));
//     selectedEduction = EducationResponse(
//       id: Hive.box('Education').get("Id"),
//       name: Hive.box('Education').get("Name"),
//     );

//     GradesControllers gradesControllers = Get.find();
//     ClassesControllers classesControllers = Get.find();
//   }

//   getDataFromBarcode(String barcode) async {
//     degreeTextController.clear();
//     buildwidget = false;
//     update();
//     final res = await StudentExamBarcodeService.getfullDataByBarcode(
//         token: atoken, barcode: barcode);

//     if (res != null) {
//       stdExBRCResMod = res;
//       if (stdExBRCResMod!.studentDegree != null) {
//         brCodeFoucs.requestFocus();
//         barcodeController.clear();
//       } else {
//         degreeController.requestFocus();
//       }
//       buildwidget = true;
//       update();
//     } else {
//       buildwidget = false;
//       update();
//     }
//   }

//   editStudentGrades() {
//     edit = true;
//     stdExBRCResMod!.studentDegree = null;
//     update();
//   }

//   updateSubjectGrade(String gradeData) async {
//     await StudentExamBarcodeService.updateDegree(
//         token: atoken, barCode: stdExBRCResMod!.barCode, degree: gradeData);

//     buildwidget = false;
//     barcodeController.clear();
//     brCodeFoucs.requestFocus();
//     update();
//   }
// }

// class SubjectDegrees {
//   String title;
//   String degree;
//   SubjectDegrees({
//     required this.title,
//     required this.degree,
//   });
}
