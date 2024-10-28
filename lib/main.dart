import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:worker_manager/worker_manager.dart';

import 'app/main_app.dart';
import 'domain/bindings/bindings.dart';

/// The main function of the app. It is the entry point of the app.
//
/// It initializes the Flutter binding, checks for updates, initializes Hive,
/// opens the necessary Hive boxes, sets up the bindings for the token,
/// and runs the app.
///
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkForUpdates();

  // workerManager.log = true;

  final numberOfCores = window.navigator.hardwareConcurrency!;

  await workerManager.init(
      isolatesCount: (numberOfCores / 5).round(), dynamicSpawning: true);

  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox('Token'),
    Hive.openBox('School'),
    Hive.openBox('Profile'),
    Hive.openBox('ControlMission'),
    Hive.openBox('ExamRoom'),
    Hive.openBox('SideMenuIndex'),
  ]);
  TokenBindings().dependencies();
  runApp(MyApp());
}

/// Checks if the current version of the app is different from the stored one.
///
/// If the versions are different, it updates the stored version and reloads
/// the page to ensure the user is running the latest version.
Future<void> checkForUpdates() async {
  final String currentVersion = await PackageInfo.fromPlatform()
      .then((packageInfo) => packageInfo.version);
  final storedVersion = window.localStorage['app_version'];

  if (storedVersion != currentVersion && storedVersion != null) {
    window.localStorage['app_version'] = currentVersion;
    //
    window.alert('A new version is available you must reload');
    window.location.reload(); // Reloads the
  }
}
