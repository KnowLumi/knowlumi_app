import 'package:freezed_annotation/freezed_annotation.dart';

part 'lumi_user.freezed.dart';

enum UserType {
  creator,
  student,
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    String? uid,
    UserType? role,
  }) = _UserData;
}

@freezed
sealed class LumiUser with _$LumiUser {
  const factory LumiUser.notRegistered() = NotRegistered;

  const factory LumiUser.lumiCreator({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? employmentType,
    String? about,
    String? photoUrl,
    String? websiteUrl,
    String? instagramUrl,
    String? linkedInUrl,
    String? youtubeUrl,
    String? refId,
    int? tmsCreate,
    int? tmsUpdate,
  }) = LumiCreator;

  const factory LumiUser.lumiStudent({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? refId,
    List<String>? interestedTopics,
    List<String>? wishListedCourses,
    List<ApprovedCourse>? accessibleCourses,
    List<EnrolledCourse>? enrolledCourses,
    int? tmsCreate,
    int? tmsUpdate,
  }) = LumiStudent;
}

@freezed
class ApprovedCourse with _$ApprovedCourse {
  const factory ApprovedCourse({
    String? courseId,
    String? accessId,
    String? refId,
  }) = _ApprovedCourse;
}

@freezed
class EnrolledCourse with _$EnrolledCourse {
  const factory EnrolledCourse({
    String? id,
    String? tmsEnroll,
  }) = _EnrolledCourse;
}
