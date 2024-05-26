
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

  List classSeats = [];
  Map<int, int> allSeatsIds = {};
  int numbers = 0;

  bool isLoading = false;

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

  @override
  void onInit() {
    getClassesRooms();
    super.onInit();
  }
}
