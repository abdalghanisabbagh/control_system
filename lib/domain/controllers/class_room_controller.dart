import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/class_room/class_room_res_model.dart';
import '../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../Data/Models/school/school_response/school_res_model.dart';
import '../../Data/Models/school/school_response/schools_res_model.dart';
import '../../Data/Models/user/login_response/user_profile_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import 'profile_controller.dart';

class ClassRoomController extends GetxController {
  List<int> classSeats = [];
  List<ClassRoomResModel> classesRooms = [];
  int count = 1;
  bool isLoading = false;
  bool isLoadingAddClassRoom = false;
  bool isLoadingEditClassRoom = false;
  int numbers = 0;
  List<SchoolResModel> schools = <SchoolResModel>[];

  final UserProfileModel? _userProfile =
      Get.find<ProfileController>().cachedUserProfile;

  Future<bool> addNewClass({
    required String name,
    required String floorName,
    required String maxCapacity,
    required int columns,
    required int classNumber,
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
        "Class_Number": classNumber,
        "Created_By": _userProfile?.iD,
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
      (r) {
        getClassesRooms();
        added = true;
      },
    );
    count = 1;
    isLoadingAddClassRoom = false;
    update();
    return added;
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
      body: {},
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

  Future<bool> editClassRoom({
    required int id,
    required String name,
    required String floorName,
    required String maxCapacity,
    required int columns,
    required int classNumber,
    required List<int> rows,
  }) async {
    bool classRoomHasBeenEdited = false;
    isLoadingEditClassRoom = true;
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
        "Class_Number": classNumber,
        "Schools_ID": Hive.box('School').get('Id'),
        "Created_By": _userProfile?.iD,
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
    isLoadingEditClassRoom = false;
    update();
    return classRoomHasBeenEdited;
  }

  Future<bool> getClassesRooms() async {
    isLoading = true;
    bool gotData = false;
    update();
    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassesRoomsResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.schoolsClasses}/school',
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

  @override
  void onInit() async {
    await getSchools().then((_) async {
      await getClassesRooms();
    });
    super.onInit();
  }

  void sortClassesByName({bool asc = true}) {
    classesRooms.sort((a, b) {
      final regex = RegExp(r'(\d+)|(\D+)');
      final aMatches = regex.allMatches(a.name!).map((m) => m[0]).toList();
      final bMatches = regex.allMatches(b.name!).map((m) => m[0]).toList();

      for (int i = 0; i < aMatches.length && i < bMatches.length; i++) {
        final aPart = aMatches[i]!;
        final bPart = bMatches[i]!;

        final isANumeric = int.tryParse(aPart) != null;
        final isBNumeric = int.tryParse(bPart) != null;

        if (isANumeric && isBNumeric) {
          final compareNumeric = int.parse(aPart).compareTo(int.parse(bPart));
          if (compareNumeric != 0) {
            return asc ? compareNumeric : -compareNumeric;
          }
        } else {
          final compareAlpha = aPart.compareTo(bPart);
          if (compareAlpha != 0) return asc ? compareAlpha : -compareAlpha;
        }
      }

      return asc ? a.name!.compareTo(b.name!) : b.name!.compareTo(a.name!);
    });
    update();
  }

  void sortClassesByCreationTime({bool asc = true}) {
    classesRooms.sort((a, b) => asc
        ? a.createdAt!.compareTo(b.createdAt!)
        : b.createdAt!.compareTo(a.createdAt!));
    update();
  }

  void sortClassesByClassNumber({bool asc = true}) {
    classesRooms.sort((a, b) {
      final regex = RegExp(r'(\d+)|(\D+)');
      final aMatches =
          regex.allMatches(a.classNumber! as String).map((m) => m[0]).toList();
      final bMatches =
          regex.allMatches(b.classNumber! as String).map((m) => m[0]).toList();

      for (int i = 0; i < aMatches.length && i < bMatches.length; i++) {
        final aPart = aMatches[i]!;
        final bPart = bMatches[i]!;

        final isANumeric = int.tryParse(aPart) != null;
        final isBNumeric = int.tryParse(bPart) != null;

        if (isANumeric && isBNumeric) {
          final compareNumeric = int.parse(aPart).compareTo(int.parse(bPart));
          if (compareNumeric != 0) {
            return asc ? compareNumeric : -compareNumeric;
          }
        } else {
          final compareAlpha = aPart.compareTo(bPart);
          if (compareAlpha != 0) return asc ? compareAlpha : -compareAlpha;
        }
      }

      return asc
          ? a.classNumber!.compareTo(b.classNumber!)
          : b.classNumber!.compareTo(a.classNumber!);
    });
    update();
  }
}
