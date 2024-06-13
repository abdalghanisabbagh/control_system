import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import '../../../Data/Models/exam_room/exam_room_model.dart';
import '../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class DistributionController extends GetxController {
  List<ExamRoomModel> listExamRoom = [];
  bool isLodingGetClassesRooms = false;
  Future<void> getExamRoomByControlMissionId(int controlMissionId) async {
    isLodingGetClassesRooms = true;
    update();

    final response = await ResponseHandler<ExamRoomResModel>().getResponse(
      path: "${ExamLinks.examRoomsControlMission}/$controlMissionId",
      converter: ExamRoomResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        listExamRoom = r.data!;
        update();
      },
    );
    isLodingGetClassesRooms = false;
  }
}
