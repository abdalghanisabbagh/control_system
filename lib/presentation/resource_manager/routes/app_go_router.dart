import 'package:control_system/presentation/views/control_mission/widgets/create_mission_widget.dart';
import 'package:control_system/presentation/views/control_mission/widgets/distribute_students.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/bindings/bindings.dart';
import '../../../domain/controllers/controllers.dart';
import '../../../domain/services/side_menue_get_controller.dart';
import '../../views/control_mission/distribution_and_details/details_and_review_mission.dart';
import '../../views/control_mission/distribution_and_details/distribution.dart';
import '../../views/index.dart';
import 'app_routes_names_and_paths.dart';

class AppGoRouter {
  static final router = GoRouter(
    navigatorKey: Get.key,
    debugLogDiagnostics: true,
    initialLocation: AppRoutesNamesAndPaths.loginScreenPath,
    routes: [
      GoRoute(
        path: AppRoutesNamesAndPaths.homeScreenPath,
        name: AppRoutesNamesAndPaths.homeScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          HomeBindings().dependencies();
          return const HomeScreen();
        },
        onExit: (context, state) {
          Get.delete<HomeController>();
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.loginScreenPath,
        name: AppRoutesNamesAndPaths.loginScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          AuthBindings().dependencies();
          return const LoginScreen();
        },
        onExit: (context, state) {
          Get.delete<AuthController>();
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.certificateScreenPath,
        name: AppRoutesNamesAndPaths.certificateScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          return const CertificatesScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.schoolsScreenPath,
        name: AppRoutesNamesAndPaths.schoolsScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          SchoolSettingBindings().dependencies();
          //  Get.find<SchoolController>();

          return const SchoolsScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.classRoomScreenPath,
        name: AppRoutesNamesAndPaths.classRoomScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          ClassRoomBindings().dependencies();
          return const ClassRoomsScreen();
        },
        onExit: (context, state) {
          // Get.find<ClassRoomController>().count = 1;
          return true;
        },
        routes: [
          GoRoute(
            path: AppRoutesNamesAndPaths.classRoomSeatsScreenPath,
            name: AppRoutesNamesAndPaths.classRoomSeatsScreenName,
            builder: (context, state) {
              return ClassRoomSeatsScreen();
            },
            onExit: (context, state) {
              Get.find<ClassRoomController>().count = 1;
              return true;
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.cohortSettingScreenPath,
        name: AppRoutesNamesAndPaths.cohortSettingScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          CohortSettingsBindings().dependencies();
          return const CohortSettingsScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.controlBatchScreenPath,
        name: AppRoutesNamesAndPaths.controlBatchScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          ControlMissingBindings().dependencies();
          return const ControlMissionScreen();
        },
        routes: [
          GoRoute(
            path: AppRoutesNamesAndPaths.reviewAndDetailsMissionPath,
            name: AppRoutesNamesAndPaths.reviewAndDetailsMissionName,
            builder: (context, state) {
              return const DetailsAndReviewMission();
            },
          ),
          GoRoute(
            path: AppRoutesNamesAndPaths.distributioncreateMissionScreenPath,
            name: AppRoutesNamesAndPaths.distributioncreateMissionScreenName,
            builder: (context, state) {
              return const DistributionScreen();
            },
            onExit: (context, state) async {
              await Get.delete<DistributionController>();
              return true;
            },
            routes: [
              GoRoute(
                path: AppRoutesNamesAndPaths.distributeStudentsScreenPath,
                name: AppRoutesNamesAndPaths.distributeStudentsScreenName,
                builder: (context, state) {
                  return const DistributeStudents();
                },
                onExit: (context, state) async {
                  await Get.delete<DistributeStudentsController>();
                  Get.find<DistributionController>().onInit();
                  return true;
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutesNamesAndPaths.createMissionScreenPath,
            name: AppRoutesNamesAndPaths.createMissionScreenName,
            builder: (context, state) {
              CreateControlMissionBindings().dependencies();
              return CreateMissionScreen();
            },
          ),
        ],
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.dashBoardScreenPath,
        name: AppRoutesNamesAndPaths.dashBoardScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          DashBoardBindings().dependencies();
          return const DashboardScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.proctorScreenPath,
        name: AppRoutesNamesAndPaths.proctorScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          ProctorBindings().dependencies();
          return const ProctorScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.setDegreesScreenPath,
        name: AppRoutesNamesAndPaths.setDegreesScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          return const SetDegreesScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.studentScreenPath,
        name: AppRoutesNamesAndPaths.studentScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          StudentsBindings().dependencies();
          return const StudentScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.subjectSettingScreenPath,
        name: AppRoutesNamesAndPaths.subjectSettingScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          SubjectSettingBindings().dependencies();
          return const SubjectSettingScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.adminScreenPath,
        name: AppRoutesNamesAndPaths.adminScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          return const AdminScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.batchDocumentsScreenPath,
        name: AppRoutesNamesAndPaths.batchDocumentsScreenName,
        builder: (context, state) {
          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          BatchDocumentsBindings().dependencies();
          return const BatchDocumentsScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.rolesScreenPath,
        name: AppRoutesNamesAndPaths.rolesScreenName,
        builder: (context, state) {
          RolesBinidings().dependencies();

          Get.find<SideMenueGetController>().onRouteChange(state.name!);
          return const RolesScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.renderSeatScreenPath,
        name: AppRoutesNamesAndPaths.renderSeatScreenName,
        builder: (context, state) {
          return const RenderSeatsExam();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.examRoomScreenPath,
        name: AppRoutesNamesAndPaths.examRoomScreenName,
        builder: (context, state) {
          return const ExamRoomScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      // GoRoute(
      //   path: AppRoutesNamesAndPaths.distributionScreenPath,
      //   name: AppRoutesNamesAndPaths.distributionScreenName,
      //   builder: (context, state) {
      //     return const DistributionScreen();
      //   },
      //   onExit: (context, state) {
      //     return true;
      //   },
      // ),
    ],
  );
}

// final pagess = [
//   GetPage(
//     name: 'test',
//     page: () => HomeScreen(),
//     bindings: [],
//     title: 'test',
//     children: []
//   ),
// ];
