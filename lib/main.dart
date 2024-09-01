import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/main_app.dart';
import 'domain/bindings/bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TokenBindings().dependencies();
  await Future.wait([
    Hive.initFlutter(),
    Hive.openBox('Token'),
    Hive.openBox('School'), // Id   --- Name
    Hive.openBox('Profile'), // Id   --- profile
    Hive.openBox('ControlMission'),
    Hive.openBox('ExamRoom'),
    Hive.openBox('SideMenueIndex'),
  ]);
  runApp(MyApp());
}
