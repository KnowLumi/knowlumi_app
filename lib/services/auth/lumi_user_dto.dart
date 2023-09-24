import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/auth/lumi_user.dart';

part 'lumi_user_dto.freezed.dart';
part 'lumi_user_dto.g.dart';

UserType getUserType(String role) {
  if (role == 'creator') {
    return UserType.creator;
  } else // role == 'student'
  {
    return UserType.student;
  }
}

@freezed
class UserDataDto with _$UserDataDto {
  const UserDataDto._();

  const factory UserDataDto({
    required String uid,
    required String role,
  }) = _UserDataDto;

  UserData toDomain() => UserData(
        uid: uid,
        role: getUserType(role),
      );

  factory UserDataDto.fromJson(Map<String, dynamic> json) =>
      _$UserDataDtoFromJson(json);
}

@freezed
class LumiCreatorDto with _$LumiCreatorDto {
  const LumiCreatorDto._();

  const factory LumiCreatorDto({
    required String id,
    required String firstName,
    String? lastName,
    required String email,
    String? phoneNumber,
    String? employmentType,
    String? about,
    String? photoUrl,
    String? websiteUrl,
    String? instagramUrl,
    String? linkedInUrl,
    String? youtubeUrl,
    String? refId,
    required int tmsCreate,
    required int tmsUpdate,
  }) = _LumiCreatorDto;

  LumiUser toDomain() => LumiUser.lumiCreator(
        id: id,
        firstName: firstName,
        lastName: lastName ?? "",
        email: email,
        phoneNumber: phoneNumber ?? "",
        employmentType: employmentType ?? "",
        about: about ?? "",
        photoUrl: photoUrl ?? "",
        websiteUrl: websiteUrl ?? "",
        instagramUrl: instagramUrl ?? "",
        linkedInUrl: linkedInUrl ?? "",
        youtubeUrl: youtubeUrl ?? "",
        refId: refId ?? "",
        tmsCreate: tmsCreate,
        tmsUpdate: tmsUpdate,
      );

  factory LumiCreatorDto.fromJson(Map<String, dynamic> json) =>
      _$LumiCreatorDtoFromJson(json);
}

@freezed
class LumiStudentDto with _$LumiStudentDto {
  const LumiStudentDto._();

  const factory LumiStudentDto({
    required String id,
    required String firstName,
    String? lastName,
    required String email,
    String? phoneNumber,
    String? photoUrl,
    String? refId,
    required List<String> interestedTopics,
    List<String>? wishListedCourses,
    List<ApprovedCourseDto>? accessibleCourses,
    List<EnrolledCourseDto>? enrolledCourses,
    required int tmsCreate,
    required int tmsUpdate,
  }) = _LumiStudentDto;

  LumiUser toDomain() => LumiUser.lumiStudent(
        id: id,
        firstName: firstName,
        lastName: lastName ?? "",
        email: email,
        phoneNumber: phoneNumber ?? "",
        photoUrl: photoUrl ?? "",
        interestedTopics: interestedTopics,
        wishListedCourses: wishListedCourses ?? <String>[],
        accessibleCourses: (accessibleCourses ?? [])
            .cast<ApprovedCourseDto>()
            .map((item) => item.toDomain())
            .toList(),
        enrolledCourses: (enrolledCourses ?? [])
            .cast<EnrolledCourseDto>()
            .map((item) => item.toDomain())
            .toList(),
        refId: refId ?? "",
        tmsCreate: tmsCreate,
        tmsUpdate: tmsUpdate,
      );

  factory LumiStudentDto.fromJson(Map<String, dynamic> json) =>
      _$LumiStudentDtoFromJson(json);
}

@freezed
class ApprovedCourseDto with _$ApprovedCourseDto {
  const ApprovedCourseDto._();

  const factory ApprovedCourseDto({
    required String courseId,
    String? accessId,
    String? refId,
  }) = _ApprovedCourseDto;

  ApprovedCourse toDomain() => ApprovedCourse(
        courseId: courseId,
        accessId: accessId ?? "",
        refId: refId ?? "",
      );

  factory ApprovedCourseDto.fromJson(Map<String, dynamic> json) =>
      _$ApprovedCourseDtoFromJson(json);
}

@freezed
class EnrolledCourseDto with _$EnrolledCourseDto {
  const EnrolledCourseDto._();

  const factory EnrolledCourseDto({
    required String courseId,
    required String tmsEnroll,
  }) = _EnrolledCourseDto;

  EnrolledCourse toDomain() => EnrolledCourse(
        id: courseId,
        tmsEnroll: tmsEnroll,
      );

  factory EnrolledCourseDto.fromJson(Map<String, dynamic> json) =>
      _$EnrolledCourseDtoFromJson(json);
}
