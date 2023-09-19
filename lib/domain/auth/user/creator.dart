import 'package:freezed_annotation/freezed_annotation.dart';

part 'creator.freezed.dart';

@freezed
class LumiCreator with _$LumiCreator {
  const factory LumiCreator({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required int phoneNumber,
    required String employmentType,
    required String about,
    required String photoUrl,
    required String websiteUrl,
    required String instagramUrl,
    required String linkedInUrl,
    required String youtubeUrl,
    String? refId,
    required int tmsCreate,
  }) = _LumiCreator;
}
