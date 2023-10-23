import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'presentation/core/entry/my_app.dart';
import 'injection.dart';
import 'init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  await Future.wait([
    initDependencies(),
    Firebase.initializeApp(),
  ]);

  runApp(MyApp());
}
