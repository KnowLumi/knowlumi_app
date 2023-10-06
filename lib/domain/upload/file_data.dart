import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_data.freezed.dart';

@freezed
class FileData with _$FileData {
  const factory FileData({
    required String fileName,
    required String fileSize,
    required File file,
  }) = _FileData;
}
