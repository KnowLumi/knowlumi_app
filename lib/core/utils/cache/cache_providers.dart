import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'course_pref.dart';

final courseCacheProvider = Provider((ref) => CoursePref.instance);
