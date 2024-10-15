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

  /// Adds a new class room to the server and updates the UI.
  ///
  /// The function takes the following parameters:
  ///
  /// - [name]: the name of the class room
  /// - [floorName]: the name of the floor of the class room
  /// - [maxCapacity]: the maximum capacity of the class room
  /// - [columns]: the number of columns of seats in the class room
  /// - [classNumber]: the number of the class room
  /// - [rows]: a list of the numbers of the rows of seats in the class room
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show that the class room has been
  /// added to the server.
  ///
  /// The function returns a boolean indicating whether the class room was added
  /// successfully.
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

  /// Deletes a class room with the given [id] from the database and returns a boolean indicating whether the delete was successful.
  ///
  /// The function takes the following parameters:
  ///
  /// - [id]: The ID of the class room to be deleted.
  ///
  /// The function will return a boolean indicating whether the delete was successful.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the list of class rooms in the [SchoolsController] and reset the UI to show that no file has been imported.
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

  /// Edits a class room with the given [id] in the database and returns a boolean indicating whether the edit was successful.
  ///
  /// The function takes the following parameters:
  ///
  /// - [id]: The ID of the class room to be edited.
  /// - [name]: The name of the class room.
  /// - [floorName]: The name of the floor where the class room is.
  /// - [maxCapacity]: The maximum capacity of the class room.
  /// - [columns]: The number of columns in the class room.
  /// - [classNumber]: The number of the class room.
  /// - [rows]: The list of rows in the class room.
  ///
  /// The function will return a boolean indicating whether the edit was successful.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the list of class rooms in the [SchoolsController] and reset the UI to show that no file has been imported.
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

  /// Gets all classes rooms from the API and sets the [classesRooms] with the classes rooms returned by the API.
  ///
  /// It sets the [isLoading] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the
  /// failure message.
  ///
  /// The function is used when the user navigates to the class rooms page.
  ///
  /// The function returns a boolean indicating whether the classes rooms
  /// were retrieved successfully.
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

  /// Gets all schools from the API and sets the [schools] with the schools returned by the API.
  ///
  /// It sets the [isLoading] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the
  /// failure message.
  ///
  /// The function is used when the user navigates to the schools page.
  ///
  /// The function returns a boolean indicating whether the schools
  /// were retrieved successfully.
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

  /// Calls [getSchools] and [getClassesRooms] to load the schools and class rooms into memory.
  ///
  /// The function is used when the user navigates to the class rooms page.
  ///
  /// The function is asynchronous and returns a void future.
  void onInit() async {
    await getSchools().then((_) async {
      await getClassesRooms();
    });
    super.onInit();
  }

  /// Sorts the class rooms by class number in ascending or descending order, using the same
  /// logic as [sortCohortsByName].
  ///
  /// [asc] is a boolean that defaults to true, indicating that the class rooms should
  /// be sorted in ascending order of class number. If [asc] is false, the class rooms are sorted
  /// in descending order of class number.
  ///
  /// The function updates the UI after sorting the list.
  ///
  /// The function is used in the class rooms page to sort the class rooms list
  /// by class number.
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

  /// Sorts the class rooms by creation time in ascending or descending order.
  ///
  /// [asc] is a boolean that defaults to true, indicating that the class rooms should
  /// be sorted in ascending order of creation time. If [asc] is false, the class rooms are sorted
  /// in descending order of creation time.
  ///
  /// The function updates the UI after sorting the list.
  ///
  /// The function is used in the class rooms page to sort the class rooms list
  /// by creation time.
  void sortClassesByCreationTime({bool asc = true}) {
    classesRooms.sort((a, b) => asc
        ? a.createdAt!.compareTo(b.createdAt!)
        : b.createdAt!.compareTo(a.createdAt!));
    update();
  }

  /// Sorts the class rooms by name in ascending or descending order, using the same
  /// logic as [sortCohortsByName].
  ///
  /// [asc] is a boolean that defaults to true, indicating that the class rooms should
  /// be sorted in ascending order of name. If [asc] is false, the class rooms are sorted
  /// in descending order of name.
  ///
  /// The function updates the UI after sorting the list.
  ///
  /// The function is used in the class rooms page to sort the class rooms list
  /// by name.
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
}
