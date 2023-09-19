import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';

@freezed
class LumiStudent with _$LumiStudent {
  const factory LumiStudent({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required int phoneNumber,
    required String photoUrl,
    String? refId,
    required List<String> interestedTopics,
    required List<String> wishListedCourses,
    required List<ApprovedCourse> accessibleCourses,
    required List<EnrolledCourse> enrolledCourses,
    required int tmsCreate,
  }) = _LumiStudent;
}

@freezed
class ApprovedCourse with _$ApprovedCourse {
  const factory ApprovedCourse({
    required String courseId,
    required String accessId,
    String? refId,
  }) = _ApprovedCourse;
}

@freezed
class EnrolledCourse with _$EnrolledCourse {
  const factory EnrolledCourse({
    required String id,
    required String tmsEnroll,
  }) = _EnrolledCourse;
}
