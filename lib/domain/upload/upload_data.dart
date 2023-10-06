import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_data.freezed.dart';

@freezed
class UploadData with _$UploadData {
  const factory UploadData({
    int? progress,
    String? uploadedUrl,
  }) = _UploadData;
}
