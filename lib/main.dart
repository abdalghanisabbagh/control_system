import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('Token');
  await Hive.openBox('School'); // Id   --- Name
  await Hive.openBox('Profile'); // Id   --- profile

  runApp(MyApp());
}
