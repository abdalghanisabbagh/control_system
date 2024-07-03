import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:control_system/Data/Models/class_desk/class_desk_res_model.dart';
import 'package:control_system/Data/Models/class_desk/class_desks_res_model.dart';
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
  int availableStudentsCount = 0;

  int numberOrRows = 0;

  List<StudentSeatNumberResModel> studentsSeatNumbers = [];
  List<StudentSeatNumberResModel> availableStudents = [];
  List<StudentSeatNumberResModel> removedStudentsFromExamRoom = [];
  List<ClassDeskResModel> classDesks = [];
  Map<int?, List<ClassDeskResModel>> classDeskCollection = {};
  List<GradeResModel> grades = [];

  Map<String, int> countByGrade = {};

  List<ValueItem> optionsGrades = [];
  List<ValueItem> optionsGradesInExamRoom = [];
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

  Future<void> getClassDesks() async {
    ResponseHandler<ClassDesksResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassDesksResModel> response =
        await responseHandler.getResponse(
      path:
          '${SchoolsLinks.classDesks}/class/${examRoomResModel.schoolClassID}',
      converter: ClassDesksResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        classDesks = r.data!;
        classDeskCollection = classDesks.groupListsBy(
          (e) => e.cloumnNum,
        );
        numberOrRows =
            classDesks.map((element) => element.cloumnNum!).reduce(max) + 1;
      },
    );
    update();
    return;
  }

  void autoGenerateSimple() {
    for (int i = 0; i < availableStudents.length; i++) {
      availableStudents[i].classDeskID = classDesks[i].id;
      availableStudents[i].examRoomID = examRoomResModel.id;
    }
    update();
  }

  void removeStudentFromDesk({required int studentSeatNumberId}) {
    availableStudents
        .firstWhere((element) => element.iD == studentSeatNumberId)
        .classDeskID = null;
    update();
  }

  void removeAllFromDesks() {
    for (var element in availableStudents) {
      element.classDeskID = null;
    }
    update();
  }

  Future<bool> finish() async {
    bool success = false;
    ResponseHandler<void> responseHandler = ResponseHandler();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentSeatNumbers}/many',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: [
        ...availableStudents.map((element) => {
              "ID": element.iD,
              "Exam_Room_ID": examRoomResModel.id,
              "Class_Desk_ID": element.classDeskID,
            }),
        ...removedStudentsFromExamRoom.map((element) => {
              "ID": element.iD,
              "Exam_Room_ID": null,
              "Class_Desk_ID": null,
            }),
      ],
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        success = true;
      },
    );
    update();
    return success;
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
        studentsSeatNumbers = r.studentSeatNumbers!
          ..removeWhere((element) =>
              element.examRoomID != null &&
              element.examRoomID != examRoomResModel.id);
        optionsGrades = studentsSeatNumbers
            .map(
              (e) => ValueItem(
                label: grades.firstWhere((g) => g.iD == e.gradesID).name!,
                value: e.gradesID!,
              ),
            )
            .toSet()
            .toList();
        availableStudents
          ..assignAll(studentsSeatNumbers
              .where((element) => element.examRoomID == examRoomResModel.id))
          ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
          ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
        studentsSeatNumbers
          ..removeWhere((element) => element.examRoomID == examRoomResModel.id)
          ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
          ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));
        availableStudentsCount =
            examRoomResModel.capacity! - availableStudents.length;
        optionsGradesInExamRoom.assignAll(availableStudents
            .map(
              (e) => ValueItem(
                label: grades.firstWhere((g) => g.iD == e.gradesID).name!,
                value: e.gradesID!,
              ),
            )
            .toSet()
            .toList());
        availableStudentsCount =
            examRoomResModel.capacity! - availableStudents.length;
        Map<int?, List<StudentSeatNumberResModel>> gradesCollection =
            studentsSeatNumbers
                .where((e) => (e.examRoomID == null))
                .groupListsBy(
                  (e) => e.gradesID,
                );

        gradesCollection.forEach((key, value) {
          countByGrade[key.toString()] = value.length;
        });
        for (var element in availableStudents
            .groupListsBy((e) => e.gradesID)
            .keys
            .where((key) => countByGrade[key.toString()] == null)
            .toSet()) {
          countByGrade[element.toString()] = 0;
        }
        isLoading = false;
        gotData = true;
      },
    );
    update();
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

  bool canAddStudents() {
    return (countByGrade[selectedItemGradeId.toString()]! -
                int.parse(numberOfStudentsController.text) >=
            0) &&
        (int.parse(numberOfStudentsController.text) +
                availableStudents.length) <=
            examRoomResModel.capacity!;
  }

  bool canRemoveStudents() {
    return availableStudents
                .where((element) => (element.gradesID == selectedItemGradeId))
                .length -
            int.parse(numberOfStudentsController.text) >=
        0;
  }

  void removeStudentFromExamRoom({required int studentSeatNumberId}) {
    studentsSeatNumbers.add(
      availableStudents
          .firstWhere((element) => element.iD == studentSeatNumberId),
    );
    ++availableStudentsCount;
    countByGrade[availableStudents
        .firstWhere((e) => e.iD == studentSeatNumberId)
        .gradesID
        .toString()] = countByGrade[availableStudents
            .firstWhere((e) => e.iD == studentSeatNumberId)
            .gradesID
            .toString()]! +
        1;
    removedStudentsFromExamRoom.add(
      availableStudents
          .firstWhere((element) => element.iD == studentSeatNumberId),
    );
    availableStudents
      ..removeWhere((element) => (element.iD == studentSeatNumberId))
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort(
        (a, b) => a.seatNumber!.compareTo(b.seatNumber!),
      );
    availableStudents
            .where((element) => (element.gradesID == selectedItemGradeId))
            .isEmpty
        ? optionsGradesInExamRoom
            .removeWhere((element) => (element.value == selectedItemGradeId))
        : null;
    update();
    return;
  }

  void removeStudentsFromExamRoom() {
    List<StudentSeatNumberResModel> removedStudents = availableStudents.reversed
        .where((element) => (element.gradesID == selectedItemGradeId))
        .take(int.parse(numberOfStudentsController.text))
        .toList();
    studentsSeatNumbers.addAll(
      removedStudents,
    );
    removedStudentsFromExamRoom
      ..addAll(removedStudents)
      ..toSet();
    studentsSeatNumbers
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort((a, b) => a.seatNumber!.compareTo(b.seatNumber!));

    availableStudents
      ..removeWhere((element) => (studentsSeatNumbers.contains(element)))
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort(
        (a, b) => a.seatNumber!.compareTo(b.seatNumber!),
      );
    availableStudentsCount += int.parse(numberOfStudentsController.text);
    countByGrade[selectedItemGradeId.toString()] =
        countByGrade[selectedItemGradeId.toString()]! +
            int.parse(numberOfStudentsController.text);
    availableStudents
            .where((element) => (element.gradesID == selectedItemGradeId))
            .isEmpty
        ? optionsGradesInExamRoom
            .removeWhere((element) => (element.value == selectedItemGradeId))
        : null;
    numberOfStudentsController.clear();
    update();
  }

  void getAvailableStudents() async {
    availableStudents.addAll(studentsSeatNumbers
        .where((element) => (element.gradesID == selectedItemGradeId))
        .take(int.parse(numberOfStudentsController.text)));
    studentsSeatNumbers
        .removeWhere((element) => availableStudents.contains(element));
    removedStudentsFromExamRoom
        .removeWhere((element) => availableStudents.contains(element));
    availableStudents
      ..sort((a, b) => a.gradesID!.compareTo(b.gradesID!))
      ..sort(
        (a, b) => a.seatNumber!.compareTo(b.seatNumber!),
      );
    availableStudentsCount -= int.parse(numberOfStudentsController.text);
    countByGrade[selectedItemGradeId.toString()] =
        countByGrade[selectedItemGradeId.toString()]! -
            int.parse(numberOfStudentsController.text);
    optionsGradesInExamRoom.contains(ValueItem(
            label: grades
                .firstWhere((element) => element.iD == selectedItemGradeId)
                .name!,
            value: selectedItemGradeId))
        ? null
        : optionsGradesInExamRoom.add(ValueItem(
            label: grades
                .firstWhere((element) => element.iD == selectedItemGradeId)
                .name!,
            value: selectedItemGradeId));
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
        await Future.wait([
          getStudentsSeatNumbers(),
          getClassDesks(),
        ]);
      }),
    ]);
    isLoading = false;
    update();
  }
}
