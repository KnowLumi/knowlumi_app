import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_failure.freezed.dart';

@freezed
sealed class UploadFailure with _$UploadFailure {
  const factory UploadFailure.failed() = Failed;
}
