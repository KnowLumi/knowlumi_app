import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/core/entry/my_app.dart';
import 'init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    initCache(),
    Firebase.initializeApp(),
  ]);

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
