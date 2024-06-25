import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/class_room/class_room_res_model.dart';
import '../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../Data/Models/school/school_response/school_res_model.dart';
import '../../Data/Models/school/school_response/schools_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class ClassRoomController extends GetxController {
  List<int> classSeats = [];
  List<ClassRoomResModel> classesRooms = [];
  int count = 1;
  bool isLoading = false;
  bool isLoadingAddClassRoom = false;
  int numbers = 0;
  List<SchoolResModel> schools = <SchoolResModel>[];

  @override
  void onInit() async {
    await getSchools().then((_) async {
      await getClassesRooms();
    });
    super.onInit();
  }

  Future<bool> getClassesRooms() async {
    isLoading = true;
    bool gotData = false;
    update();
    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassesRoomsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.schoolsClasses,
      converter: ClassesRoomsResModel.fromJson,
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
        classesRooms = r.data!;
        isLoading = false;
        gotData = true;
        update();
      },
    );
    return gotData;
  }

  Future<bool> getSchools() async {
    isLoading = true;
    bool gotData = false;
    update();
    ResponseHandler<SchoolsResModel> responseHandler = ResponseHandler();
    Either<Failure, SchoolsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.getAllSchools,
      converter: SchoolsResModel.fromJson,
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
        schools = r.data!;
        isLoading = false;
        gotData = true;
        update();
      },
    );
    return gotData;
  }

  Future<bool> deleteClassRoom({
    required int id,
  }) async {
    bool classRoomHasBeenDeleted = false;

    ResponseHandler<ClassRoomResModel> responseHandler = ResponseHandler();

    Either<Failure, ClassRoomResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.schoolsClasses}/$id',
      converter: ClassRoomResModel.fromJson,
      type: ReqTypeEnum.DELETE,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        classRoomHasBeenDeleted = false;
      },
      (r) {
        getClassesRooms();
        classRoomHasBeenDeleted = true;
      },
    );
    update();
    return classRoomHasBeenDeleted;
  }

  Future<bool> addNewClass({
    required String name,
    required String floorName,
    required String maxCapacity,
    required int columns,
    required List<int> rows,
  }) async {
    isLoadingAddClassRoom = true;
    bool added = false;
    update();
    ResponseHandler<ClassRoomResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassRoomResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.schoolsClasses,
      converter: ClassRoomResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
        "Max_Capacity": maxCapacity,
        "Floor": floorName,
        "Rows": rows.toString(),
        "Columns": columns,
        "Schools_ID": Hive.box('School').get('Id'),
        "Created_By": Hive.box('Profile').get('ID'),
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        added = false;
      },
      (r) async {
        getClassesRooms();
        added = true;
      },
    );
    count = 1;
    isLoadingAddClassRoom = false;
    update();
    return added;
  }

  Future<bool> editClassRoom({
    required int id,
    required String name,
    required String floorName,
    required String maxCapacity,
    required int columns,
    required List<int> rows,
  }) async {
    bool classRoomHasBeenEdited = false;
    update();
    ResponseHandler<ClassRoomResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassRoomResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.schoolsClasses}/$id',
      converter: ClassRoomResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: {
        "Name": name,
        "Max_Capacity": maxCapacity,
        "Floor": floorName,
        "Rows": rows.toString(),
        "Columns": columns,
        "Schools_ID": Hive.box('School').get('Id'),
        "Created_By": Hive.box('Profile').get('ID')
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        classRoomHasBeenEdited = false;
      },
      (r) {
        getClassesRooms();
        classRoomHasBeenEdited = true;
        update();
      },
    );
    return classRoomHasBeenEdited;
  }
}
