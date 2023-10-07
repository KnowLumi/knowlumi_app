import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

import '../course/lumi_curriculum.dart';
import 'file_data.dart';
import 'upload_data.dart';
import 'file_pick_failure.dart';

abstract interface class IUploadRepo {
  Future<Either<FilePickFailure, Option<FileData>>> pickContent(
    ContentType contentType,
  );
  Stream<UploadData> uploadContent({
    required ContentType type,
    required PlatformFile file,
  });
}
