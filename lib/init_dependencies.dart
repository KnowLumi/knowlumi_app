import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

import 'core/utils/cache/course_pref.dart';

Future<void> initDependencies() async {
  final appDocDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await CoursePref.init();
}
