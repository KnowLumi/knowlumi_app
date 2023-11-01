import 'package:freezed_annotation/freezed_annotation.dart';

import 'upload_failure.dart';

part 'upload_data.freezed.dart';

@freezed
sealed class UploadData with _$UploadData {
  const factory UploadData.uploading(double progress) = Uploading;
  const factory UploadData.uploaded(String url) = Uploaded;
  const factory UploadData.error(UploadFailure error) = Error;
}
