import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knowlumi_app/domain/course/lumi_course.dart';
import 'package:knowlumi_app/domain/course/lumi_curriculum.dart';

part 'lumi_course_type_wrapper.freezed.dart';

@freezed
class LumiCourseTypeWrapper with _$LumiCourseTypeWrapper {
  const factory LumiCourseTypeWrapper({
    required LumiCourse course,
    required LumiCurriculum curriculum,
  }) = _LumiCourseTypeWrapper;
}
