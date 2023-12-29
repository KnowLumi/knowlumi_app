import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/course/lumi_course_type_wrapper.dart';

part 'std_course_notifier.freezed.dart';

@freezed
class StdCourseNotifier with _$StdCourseNotifier {
  const factory StdCourseNotifier.initial() = _Initial;
  const factory StdCourseNotifier.loading() = _Loading;
  const factory StdCourseNotifier.recommendedCourses(
    List<LumiCourseTypeWrapper> courses,
  ) = _RecommendedCourses;
  const factory StdCourseNotifier.failure(String message) = _Failure;
}
