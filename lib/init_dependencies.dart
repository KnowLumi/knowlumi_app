import 'package:hive_flutter/adapters.dart';

import 'core/utils/cache/course_pref.dart';

Future<void> initCache() async {
  await Hive.initFlutter();
  await CoursePref.init();
}
