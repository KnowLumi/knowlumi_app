import 'dart:io';

import 'package:knowlumi_app/domain/upload/file_data.dart';
import 'package:knowlumi_app/domain/upload/upload_data.dart';

abstract interface class IUploadRepo {
  Future<FileData> pickContent(ContentType contentType);
  Stream<UploadData> uploadContent({
    required ContentType type,
    required File file,
  });
}
