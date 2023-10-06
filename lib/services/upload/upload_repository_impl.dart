import 'dart:io';

import '../../domain/upload/file_data.dart';
import '../../domain/upload/i_upload_repo.dart';
import '../../domain/upload/upload_data.dart';

class UploadRepository implements IUploadRepo {
  @override
  Future<FileData> pickContent(ContentType contentType) {
    // TODO: implement pickContent
    throw UnimplementedError();
  }

  @override
  Stream<UploadData> uploadContent(
      {required ContentType type, required File file}) {
    // TODO: implement uploadContent
    throw UnimplementedError();
  }
}
