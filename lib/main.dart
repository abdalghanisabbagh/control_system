import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/main_app.dart';
import 'domain/bindings/bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox('Token'),
    Hive.openBox('School'), // Id   --- Name
    Hive.openBox('Profile'), // Id   --- profile
    Hive.openBox('ControlMission'),
    Hive.openBox('ExamRoom'),
    Hive.openBox('SideMenueIndex'),
  ]);
  TokenBindings().dependencies();
  runApp(MyApp());
}
