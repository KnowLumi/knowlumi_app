import 'package:freezed_annotation/freezed_annotation.dart';

part 'std_course_failures.freezed.dart';

@freezed
sealed class StdCourseFailure with _$StdCourseFailure {
  const factory StdCourseFailure.serverFailure() = _ServerFailure;
}
