import 'package:freezed_annotation/freezed_annotation.dart';

part 'crt_course_failures.freezed.dart';

@freezed
sealed class CrtCourseFailure with _$CrtCourseFailure {
  const factory CrtCourseFailure.serverFailure() = ServerFailure;
}
