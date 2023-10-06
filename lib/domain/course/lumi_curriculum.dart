import 'package:freezed_annotation/freezed_annotation.dart';

part 'lumi_curriculum.freezed.dart';

enum ContentType {
  video,
  image,
  pdf,
}

extension ValueX on ContentType {
  String get value => switch (this) {
        ContentType.video => 'video',
        ContentType.image => 'image',
        ContentType.pdf => 'pdf',
      };
}

@freezed
class LumiCurriculum with _$LumiCurriculum {
  const factory LumiCurriculum({
    String? id,
    List<Section>? sections,
    int? tmsCreate,
    int? tmsUpdate,
  }) = _LumiCurriculum;
}

@freezed
class Section with _$Section {
  const factory Section({
    int? templateId,
    String? title,
    String? subtitle,
    List<Lesson>? lessons,
  }) = _Section;
}

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    int? order,
    String? title,
    String? description,
    ContentType? contentType,
    String? url,
  }) = _Lesson;
}
