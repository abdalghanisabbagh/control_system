import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:control_system/Data/Models/school/grade_response/grade_res_model.dart';
import 'package:control_system/Data/Models/student_seat/student_seat_res_model.dart';
import 'package:control_system/Data/Models/student_seat/students_seats_numbers_res_model.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class DistributeStudentsController extends GetxController {
  ExamRoomResModel examRoomResModel = ExamRoomResModel();

  TextEditingController numberOfStudentsController = TextEditingController();

  List<StudentSeatNumberResModel> studentsSeatNumbers = [];
  List<StudentSeatNumberResModel> availableStudents = [];
  List<GradeResModel> grades = [];

  List<ValueItem> optionsGrades = [];
  int selectedItemGradeId = -1;

  bool isLoading = false;
  bool isLoadingStudents = false;

  Future<void> saveExamRoom(ExamRoomResModel examRoomResModel) async {
    this.examRoomResModel = examRoomResModel;
    update();
    Hive.box('ExamRoom').putAll(examRoomResModel.toJson());
  }

  Future<void> getExamRoom() async {
    examRoomResModel = Hive.box('ExamRoom').containsKey('ID')
        ? ExamRoomResModel(
            id: Hive.box('ExamRoom').get('ID'),
            name: Hive.box('ExamRoom').get('Name'),
            stage: Hive.box('ExamRoom').get('Stage'),
            capacity: Hive.box('ExamRoom').get('Capacity'),
            controlMissionID: Hive.box('ExamRoom').get('Control_Mission_ID'),
            schoolClassID: Hive.box('ExamRoom').get('School_Class_ID'),
          )
        : ExamRoomResModel();
    update();
  }

  Future<bool> getStudentsSeatNumbers() async {
    isLoading = true;
    update();
    bool gotData = false;

    ResponseHandler<StudentsSeatsNumbersResModel> responseHandler =
        ResponseHandler();

    Either<Failure, StudentsSeatsNumbersResModel> response =
        await responseHandler.getResponse(
      path:
          '${StudentsLinks.studentSeatNumbersControlMission}/${examRoomResModel.controlMissionID}',
      converter: StudentsSeatsNumbersResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLoading = false;
        gotData = false;
        update();
      },
      (r) {
        studentsSeatNumbers = r.studentSeatNumbers!;
        Map<String, int> countByGrade = {};

        Map<int?, List<StudentSeatNumberResModel>> gradesCollection =
            studentsSeatNumbers
                .where((e) => (e.examRoomID == null))
                .groupListsBy(
                  (e) => e.gradesID,
                );

        gradesCollection.forEach((key, value) {
          countByGrade[key.toString()] = value.length;
        });

        optionsGrades = studentsSeatNumbers
            .map(
              (e) => ValueItem(
                label:
                    '${grades.firstWhere((g) => (g.iD == e.gradesID) && (e.examRoomID == null)).name!} (${countByGrade[e.gradesID.toString()]})',
                value: e.gradesID!,
              ),
            )
            .toSet()
            .toList();
        isLoading = false;
        gotData = true;
        update();
      },
    );
    return gotData;
  }

  Future<bool> getGradesBySchoolId() async {
    int schoolId = await Hive.box('School').get('Id');

    bool gotData = false;
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: "${SchoolsLinks.gradesSchools}/$schoolId",
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((l) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      gotData = false;
    }, (r) {
      grades = r.data!;
      gotData = true;
    });

    return gotData;
  }

  void getAvailableStudents() async {
    availableStudents.addAll(studentsSeatNumbers
        .where((element) => (element.gradesID == selectedItemGradeId))
        .take(int.parse(numberOfStudentsController.text))
        .toList());
    studentsSeatNumbers
        .removeWhere((element) => availableStudents.contains(element));
    availableStudents
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort(
        (a, b) => a.seatNumber!.compareTo(b.seatNumber!),
      );
    numberOfStudentsController.clear();
    update();
    return;
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading = true;
    update();
    await Future.wait([
      getExamRoom().then((_) async => getGradesBySchoolId()).then((_) async {
        getStudentsSeatNumbers();
      }),
    ]);
    isLoading = false;
    update();
  }
}
