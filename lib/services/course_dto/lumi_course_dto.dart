import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/course/lumi_course.dart';

part 'lumi_course_dto.freezed.dart';
part 'lumi_course_dto.g.dart';

@freezed
class LumiCourseDto with _$LumiCourseDto {
  const LumiCourseDto._();

  const factory LumiCourseDto({
    String? id,
    String? creatorId,
    String? curriculumId,
    bool? isPaid,
    int? amount,
    bool? isPublished,
    String? courseName,
    String? description,
    String? previewImageUrl,
    String? previewVideoUrl,
    String? syllabusPdfUrl,
    String? whatsappUrl,
    int? studentsEnrolled,
    int? tmsCreate,
    int? tmsUpdate,
  }) = _LumiCourseDto;

  LumiCourse toDomain() => LumiCourse(
        id: id,
        creatorId: creatorId,
        curriculumId: curriculumId,
        isPaid: isPaid,
        amount: amount,
        isPublished: isPublished ?? false,
        courseName: courseName,
        description: description,
        previewImageUrl: previewImageUrl ?? "",
        previewVideoUrl: previewVideoUrl ?? "",
        syllabusPdfUrl: syllabusPdfUrl ?? "",
        whatsappUrl: whatsappUrl ?? "",
        studentsEnrolled: studentsEnrolled ?? 0,
        tmsCreate: tmsCreate,
        tmsUpdate: tmsUpdate,
      );

  factory LumiCourseDto.fromDomain(LumiCourse course) => LumiCourseDto(
        id: course.id,
        creatorId: course.creatorId,
        curriculumId: course.curriculumId,
        isPublished: course.isPublished,
        isPaid: course.isPaid,
        amount: course.amount,
        courseName: course.courseName,
        description: course.description,
        previewImageUrl: course.previewImageUrl,
        previewVideoUrl: course.previewVideoUrl,
        studentsEnrolled: course.studentsEnrolled,
        syllabusPdfUrl: course.syllabusPdfUrl,
        whatsappUrl: course.whatsappUrl,
        tmsCreate: course.tmsCreate,
        tmsUpdate: course.tmsUpdate,
      );

  factory LumiCourseDto.fromJson(Map<String, dynamic> json) =>
      _$LumiCourseDtoFromJson(json);
}
