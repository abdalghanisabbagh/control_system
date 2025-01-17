import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/bindings/bindings.dart';
import '../../../domain/controllers/controllers.dart';
import '../../../domain/services/side_menue_get_controller.dart';
import '../../views/control_mission/widgets/opreation_control_mission_screen.dart';
import '../../views/views.dart';
import '../ReusableWidget/page_not_found_screen.dart';
import 'app_routes_names_and_paths.dart';

class AppGoRouter {
  static final router = GoRouter(
    navigatorKey: Get.key,
    debugLogDiagnostics: true,
    initialLocation: AppRoutesNamesAndPaths.loginScreenPath,
    errorBuilder: (context, state) {
      return const PageNotFoundScreen();
    },
    redirect: (context, state) async {
      AuthBindings().dependencies();
      final isLoggedIn = Get.find<AuthController>().isLogin;
      if (state.path == AppRoutesNamesAndPaths.loginScreenPath) {
        return null;
      } else if (isLoggedIn) {
        return null;
      } else {
        return AppRoutesNamesAndPaths.loginScreenPath;
      }
    },
    routes: [
      GoRoute(
        path: AppRoutesNamesAndPaths.loginScreenPath,
        name: AppRoutesNamesAndPaths.loginScreenName,
        builder: (context, state) {
          AuthBindings().dependencies();
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
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
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
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
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
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
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
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
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
          CohortSettingsBindings().dependencies();
          return const CohortSettingsScreen();
        },
        routes: [
          GoRoute(
            path: AppRoutesNamesAndPaths.operationCohortScreenPath,
            name: AppRoutesNamesAndPaths.operationCohortScreenName,
            builder: (context, state) {
              return const OperationCohortScreen();
            },
          )
        ],
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.controlBatchScreenPath,
        name: AppRoutesNamesAndPaths.controlBatchScreenName,
        builder: (context, state) {
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
          ControlMissingBindings().dependencies();
          return const ControlMissionScreen();
        },
        routes: [
          GoRoute(
            path: AppRoutesNamesAndPaths.addNewStudentsToControlMissionPath,
            name: AppRoutesNamesAndPaths.addNewStudentsToControlMissionName,
            builder: (context, state) {
              AddNewStudentsToControlMissionBindings().dependencies();
              return const AddStudentsToControlMissionScreen();
            },
            onExit: (context, state) async {
              await Get.delete<AddNewStudentsToControlMissionController>();
              Get.find<ControlMissionController>().onInit();
              return true;
            },
          ),
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
              Get.find<ControlMissionController>().onInit();
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
          GoRoute(
            path: AppRoutesNamesAndPaths.operationControlScreenPath,
            name: AppRoutesNamesAndPaths.operationControlScreenName,
            builder: (context, state) {
              CreateControlMissionBindings().dependencies();
              return const OpreationControlMissionScreen();
            },
          ),
        ],
        onExit: (context, state) {
          Get.delete<CreateControlMissionBindings>();
          Get.find<ControlMissionController>().onInit();
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.dashBoardScreenPath,
        name: AppRoutesNamesAndPaths.dashBoardScreenName,
        builder: (context, state) {
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
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
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
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
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
          BarcodeBindings().dependencies();
          return SetDegreesScreen();
        },
        onExit: (context, state) {
          Get.delete<BarcodeController>();
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.studentScreenPath,
        name: AppRoutesNamesAndPaths.studentScreenName,
        builder: (context, state) {
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
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
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
          SubjectSettingBindings().dependencies();
          return const SubjectSettingScreen();
        },
        routes: [
          GoRoute(
            path: AppRoutesNamesAndPaths.oprerationsScreenPath,
            name: AppRoutesNamesAndPaths.oprerationsScreenName,
            builder: (context, state) {
              SubjectSettingBindings().dependencies();
              return const OperationWidget();
            },
          ),
        ],
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
          path: AppRoutesNamesAndPaths.adminScreenPath,
          name: AppRoutesNamesAndPaths.adminScreenName,
          builder: (context, state) {
            AdminBindings().dependencies();
            Get.find<SideMenuGetController>().onRouteChange(state.name!);
            return const AdminScreen();
          },
          onExit: (context, state) {
            return true;
          },
          routes: [
            GoRoute(
              path: AppRoutesNamesAndPaths.usersInSchoolScreenPath,
              name: AppRoutesNamesAndPaths.usersInSchoolScreenName,
              builder: (context, state) {
                AdminBindings().dependencies();
                return const UserInSchoolWidget();
              },
              onExit: (context, state) {
                return true;
              },
            ),
            GoRoute(
              path: AppRoutesNamesAndPaths.allusersScreenPath,
              name: AppRoutesNamesAndPaths.allUsersScreenName,
              builder: (context, state) {
                AdminBindings().dependencies();
                return const AllUserWidget();
              },
              onExit: (context, state) {
                return true;
              },
            ),
          ]),
      GoRoute(
        path: AppRoutesNamesAndPaths.batchDocumentsScreenPath,
        name: AppRoutesNamesAndPaths.batchDocumentsScreenName,
        builder: (context, state) {
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
          BatchDocumentsBindings().dependencies();
          return const BatchDocumentsScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.privilegesScreenPath,
        name: AppRoutesNamesAndPaths.privilegesScreenName,
        builder: (context, state) {
          RolesBindings().dependencies();

          Get.find<SideMenuGetController>().onRouteChange(state.name!);
          return const PrivilegesScreen();
        },
        onExit: (context, state) {
          Get.delete<PrivilegesController>();
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.profileScreenPath,
        name: AppRoutesNamesAndPaths.profileScreenName,
        builder: (context, state) {
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
          return ProfileWidget();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.systemLoggerScreenPath,
        name: AppRoutesNamesAndPaths.systemLoggerScreenName,
        builder: (context, state) {
          SystemLoggerBindings().dependencies();
          Get.find<SideMenuGetController>().onRouteChange(state.name!);
          return const SystemLoggerScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
    ],
  );
}
