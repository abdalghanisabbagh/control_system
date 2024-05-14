import 'package:control_system/presentation/resource_manager/routes/app_routes_names_and_paths.dart';
import 'package:control_system/presentation/views/Login/login_screen.dart';
import 'package:control_system/presentation/views/certificates/certificates_screen.dart';
import 'package:control_system/presentation/views/class_rooms/class_rooms_screen.dart';
import 'package:control_system/presentation/views/cohort_settings/cohort_settings_screen.dart';
import 'package:control_system/presentation/views/control_mession/control_mession_screen.dart';
import 'package:control_system/presentation/views/dashboard/dash_board_screen.dart';
import 'package:control_system/presentation/views/proctor/proctor_screen.dart';
import 'package:control_system/presentation/views/schools/school_screen.dart';
import 'package:control_system/presentation/views/seating_numbers/seating_numbers_screen.dart';
import 'package:control_system/presentation/views/set_degrees/set_degrees_screen.dart';
import 'package:control_system/presentation/views/student/student_screen.dart';
import 'package:control_system/presentation/views/subject_setting/subject_setting_screen.dart';
import 'package:control_system/presentation/views/user_screen/user_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/indices/index.dart';
import '../../views/home/home_screen.dart';

class AppGoRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutesNamesAndPaths.loginScreenPath,
    routes: [
      GoRoute(
        path: AppRoutesNamesAndPaths.homeScreenPath,
        name: AppRoutesNamesAndPaths.homeScreenName,
        builder: (context, state) {
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
          AuthBindings().dependencies();
          return const LoginScreen();
        },
        onExit: (context, state) {
          Get.delete<AuthController>();
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.schoolsScreenPath,
        name: AppRoutesNamesAndPaths.schoolsScreenName,
        builder: (context, state) {
          return const SchoolsScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.certificateScreenPath,
        name: AppRoutesNamesAndPaths.certificateScreenName,
        builder: (context, state) {
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
          return const ClassRoomsScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.cohortSettingScreenPath,
        name: AppRoutesNamesAndPaths.cohortSettingScreenName,
        builder: (context, state) {
          return const CohortSettingsScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.controlMissionScreenPath,
        name: AppRoutesNamesAndPaths.controlMissionScreenName,
        builder: (context, state) {
          return const ControlMessionScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.dashBoardScreenPath,
        name: AppRoutesNamesAndPaths.dashBoardScreenName,
        builder: (context, state) {
          return const DashBoardScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.proctorScreenPath,
        name: AppRoutesNamesAndPaths.proctorScreenName,
        builder: (context, state) {
          return const ProctorScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.seatingNumbersScreenPath,
        name: AppRoutesNamesAndPaths.seatingNumbersScreenName,
        builder: (context, state) {
          return const SeatingNumbersScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.setDegreesScreenPath,
        name: AppRoutesNamesAndPaths.setDegreesScreenName,
        builder: (context, state) {
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
          return const SubjectSettingScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.userScreenPath,
        name: AppRoutesNamesAndPaths.userScreenPath,
        builder: (context, state) {
          return const UserScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
    ],
  );
}
