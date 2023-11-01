import 'package:freezed_annotation/freezed_annotation.dart';

part 'lumi_course.freezed.dart';

@freezed
class LumiCourse with _$LumiCourse {
  const LumiCourse._();

  const factory LumiCourse({
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
  }) = _LumiCourse;

  factory LumiCourse.empty() => const LumiCourse();
}
