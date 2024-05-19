import 'package:control_system/domain/indices/index.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TokenBindings().dependencies();
  await Hive.initFlutter();
  await Hive.openBox('Token');
  await Hive.openBox('School'); // Id   --- Name
  await Hive.openBox('Profile'); // Id   --- profile

  runApp(MyApp());
}
