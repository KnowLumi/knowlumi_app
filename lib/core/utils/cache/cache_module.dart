import 'package:injectable/injectable.dart';
import 'package:knowlumi_app/core/utils/cache/course_pref.dart';

@module
abstract class CacheModule {
  @lazySingleton
  CoursePref get courseCache => CoursePref.instance;
}
