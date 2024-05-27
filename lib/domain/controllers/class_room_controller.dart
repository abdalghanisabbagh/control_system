import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../Data/Models/class_room/class_room_res_model.dart';
import '../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class ClassRoomController extends GetxController {
  List<ClassRoomResModel> classesRooms = [];

  List<int> classSeats = [];
  int numbers = 0;
  bool isLoading = false;
  bool isLoadingAddClassRoom = false;
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
        classesRooms.removeWhere((element) => element.iD == id);
        classRoomHasBeenDeleted = true;
      },
    );
    update();
    return classRoomHasBeenDeleted;
  }

  @override
  void onInit() {
    getClassesRooms();
    super.onInit();
  }

  Future<bool> addNewClass({
    required String name,
    required String floorName,
    required String maxCapacity,
    required int columns,
    required List<int> rows,
  }) async {
    isLoadingAddClassRoom = true;
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
        "Schools_ID": 1,
        "Created_By": 1
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {},
    );
    isLoadingAddClassRoom = false;
    update();
    return true;
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
        "Schools_ID": 1,
        "Created_By": 1
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
        classesRooms.removeWhere((element) => element.iD == id);
        classesRooms.add(r);
        classRoomHasBeenEdited = true;
        update();
      },
    );
    return classRoomHasBeenEdited;
  }
}
