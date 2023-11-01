import 'package:freezed_annotation/freezed_annotation.dart';

import 'lumi_course.dart';
import 'lumi_curriculum.dart';

part 'lumi_course_type_wrapper.freezed.dart';

@freezed
class LumiCourseTypeWrapper with _$LumiCourseTypeWrapper {
  const factory LumiCourseTypeWrapper({
    required LumiCourse course,
    required LumiCurriculum curriculum,
  }) = _LumiCourseTypeWrapper;
}
