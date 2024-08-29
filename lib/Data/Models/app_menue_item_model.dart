import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

import '../../presentation/resource_manager/routes/app_routes_names_and_paths.dart';

class AppMenueItem {
  static List<AppMenueItem> allMenue = [
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.studentScreenName,
        pageNumber: '1000',
        routeName: AppRoutesNamesAndPaths.studentScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsStudent)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.controlBatchScreenName,
        pageNumber: '2000',
        routeName: AppRoutesNamesAndPaths.controlBatchScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsExam)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.batchDocumentsScreenName,
        pageNumber: '3000',
        routeName: AppRoutesNamesAndPaths.batchDocumentsScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.setDegreesScreenName,
        pageNumber: '4000',
        routeName: AppRoutesNamesAndPaths.setDegreesScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsProccess)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.schoolsScreenName,
        pageNumber: '5000',
        routeName: AppRoutesNamesAndPaths.schoolsScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsCampus)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.classRoomScreenName,
        pageNumber: '6000',
        routeName: AppRoutesNamesAndPaths.classRoomScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsClassRooms)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.subjectSettingScreenName,
        pageNumber: '7000',
        routeName: AppRoutesNamesAndPaths.subjectSettingScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsSupject)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.cohortSettingScreenName,
        pageNumber: '8000',
        routeName: AppRoutesNamesAndPaths.cohortSettingScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsCohort)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.adminScreenName,
        pageNumber: '9000',
        routeName: AppRoutesNamesAndPaths.adminScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsAdmin)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.proctorScreenName,
        pageNumber: '10000',
        routeName: AppRoutesNamesAndPaths.proctorScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc)),
    AppMenueItem(
        pageName: AppRoutesNamesAndPaths.rolesScreenName,
        pageNumber: '11000',
        routeName: AppRoutesNamesAndPaths.rolesScreenName,
        iconWidget: Image.asset(AssetsManager.assetsIconsRoles)),
  ];

  Widget? iconWidget;

  String pageName;
  String pageNumber;
  String? routeName;
  AppMenueItem({
    required this.pageName,
    required this.pageNumber,
    this.routeName,
    this.iconWidget,
  });
}
