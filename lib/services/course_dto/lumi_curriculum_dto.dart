import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/course/lumi_curriculum.dart';

part 'lumi_curriculum_dto.freezed.dart';
part 'lumi_curriculum_dto.g.dart';

ContentType? getContentType(String? type) {
  switch (type) {
    case ('video'):
      return ContentType.video;
    case ('image'):
      return ContentType.image;
    case ('pdf'):
      return ContentType.pdf;
    default:
      return null;
  }
}

@freezed
class LumiCurriculumDto with _$LumiCurriculumDto {
  const LumiCurriculumDto._();

  @JsonSerializable(explicitToJson: true)
  const factory LumiCurriculumDto({
    String? id,
    List<SectionDto>? sections,
    int? tmsCreate,
    int? tmsUpdate,
  }) = _LumiCurriculumDto;

  LumiCurriculum toDomain() => LumiCurriculum(
        id: id,
        sections: (sections ?? [])
            .cast<SectionDto>()
            .map((item) => item.toDomain())
            .toList(),
        tmsCreate: tmsCreate,
        tmsUpdate: tmsUpdate,
      );

  factory LumiCurriculumDto.fromDomain(LumiCurriculum curriculum) =>
      LumiCurriculumDto(
        id: curriculum.id,
        sections: (curriculum.sections ?? <Section>[])
            .map((item) => SectionDto.fromDomain(item))
            .toList(),
        tmsCreate: curriculum.tmsCreate,
        tmsUpdate: curriculum.tmsUpdate,
      );

  factory LumiCurriculumDto.fromJson(Map<String, dynamic> json) =>
      _$LumiCurriculumDtoFromJson(json);
}

@freezed
class SectionDto with _$SectionDto {
  const SectionDto._();

  @JsonSerializable(explicitToJson: true)
  const factory SectionDto({
    int? templateId,
    String? title,
    String? subtitle,
    List<LessonDto>? lessons,
  }) = _SectionDto;

  Section toDomain() => Section(
        templateId: templateId,
        title: title,
        subtitle: subtitle,
        lessons: (lessons ?? [])
            .cast<LessonDto>()
            .map((item) => item.toDomain())
            .toList(),
      );

  factory SectionDto.fromDomain(Section section) => SectionDto(
        templateId: section.templateId,
        title: section.title,
        subtitle: section.subtitle,
        lessons: (section.lessons ?? <Lesson>[])
            .map(
              (item) => LessonDto.fromDomain(item),
            )
            .toList(),
      );

  factory SectionDto.fromJson(Map<String, dynamic> json) =>
      _$SectionDtoFromJson(json);
}

@freezed
class LessonDto with _$LessonDto {
  const LessonDto._();

  const factory LessonDto({
    int? order,
    String? title,
    String? description,
    String? contentType,
    String? url,
  }) = _LessonDto;

  Lesson toDomain() => Lesson(
        order: order,
        title: title,
        description: description,
        contentType: getContentType(contentType),
        url: url ?? "",
      );

  factory LessonDto.fromDomain(Lesson lesson) => LessonDto(
        order: lesson.order,
        title: lesson.title,
        description: lesson.description,
        contentType: lesson.contentType?.value,
        url: lesson.url,
      );

  factory LessonDto.fromJson(Map<String, dynamic> json) =>
      _$LessonDtoFromJson(json);
}
