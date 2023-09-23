import 'package:freezed_annotation/freezed_annotation.dart';

part 'lumi_user.freezed.dart';

enum UserType {
  creator,
  student,
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    required String uid,
    required UserType role,
  }) = _UserData;
}

@freezed
sealed class LumiUser with _$LumiUser {
  const factory LumiUser.notRegistered() = NotRegistered;

  const factory LumiUser.lumiCreator({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String employmentType,
    required String about,
    required String photoUrl,
    required String websiteUrl,
    required String instagramUrl,
    required String linkedInUrl,
    required String youtubeUrl,
    required String refId,
    required int tmsCreate,
    required int tmsUpdate,
  }) = LumiCreator;

  const factory LumiUser.lumiStudent({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String photoUrl,
    required String refId,
    required List<String> interestedTopics,
    required List<String> wishListedCourses,
    required List<ApprovedCourse> accessibleCourses,
    required List<EnrolledCourse> enrolledCourses,
    required int tmsCreate,
    required int tmsUpdate,
  }) = LumiStudent;
}

@freezed
class ApprovedCourse with _$ApprovedCourse {
  const factory ApprovedCourse({
    required String courseId,
    required String accessId,
    required String refId,
  }) = _ApprovedCourse;
}

@freezed
class EnrolledCourse with _$EnrolledCourse {
  const factory EnrolledCourse({
    required String id,
    required String tmsEnroll,
  }) = _EnrolledCourse;
}
