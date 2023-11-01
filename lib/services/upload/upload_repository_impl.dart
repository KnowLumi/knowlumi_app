import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../domain/course/lumi_curriculum.dart';
import '../../domain/upload/file_data.dart';
import '../../domain/upload/file_pick_failure.dart';
import '../../domain/upload/i_upload_repo.dart';
import '../../domain/upload/upload_data.dart';

class UploadRepository implements IUploadRepo {
  @override
  Future<Either<FilePickFailure, Option<FileData>>> pickContent(
      ContentType contentType) async {
    FileData? fileData;
    switch (contentType) {
      case ContentType.image:
        fileData = await _pickerHelper(['jpg', 'jpeg', 'png'], FileType.image);
        break;
      case ContentType.video:
        fileData = await _pickerHelper(['mp4'], FileType.video, isVideo: true);
        if (fileData != null) {
          int maxSizeBytes = 500 * 1024 * 1024; // * 500 MB in bytes

          if (fileData.file.size > maxSizeBytes) {
            return left(const FilePickFailure.exceedsMaxSize());
          }
        }
        break;
      case ContentType.pdf:
        fileData = await _pickerHelper(['pdf'], FileType.custom);
        break;
    }

    return right(optionOf(fileData));
  }

  Future<FileData?> _pickerHelper(
    List<String> extensions,
    FileType fileType, {
    bool isVideo = false,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowedExtensions: extensions,
      withData: !isVideo,
      withReadStream: isVideo,
    );

    if (result != null && result.files.isNotEmpty) {
      final platformFile = result.files.first;

      final fileData = FileData(
        fileName: platformFile.name,
        fileSize: platformFile.bytes.toString(),
        file: platformFile,
      );

      return fileData;
    } else {
      return null;
    }
  }

  @override
  Stream<UploadData> uploadContent({
    required ContentType type,
    required PlatformFile file,
  }) async* {
    final filePath = file.path;
    final mimeType = filePath != null ? lookupMimeType(filePath) : null;
    final contentType = mimeType != null ? MediaType.parse(mimeType) : null;

    // todo: Add upload url
    final uri = Uri.parse("");
    final request = http.MultipartRequest('POST', uri);

    late final http.MultipartFile multipartFile;
    //
    // try {
    //   switch (type) {
    //     case ContentType.video:
    //       final fileReadStream = file.readStream;
    //       if (fileReadStream == null) {
    //         throw Exception('Cannot read file from null stream');
    //       }
    //       final stream = http.ByteStream(fileReadStream);
    //
    //       multipartFile = http.MultipartFile(
    //         'file',
    //         stream,
    //         file.size,
    //         filename: file.name,
    //         contentType: contentType,
    //       );
    //       break;
    //     case ContentType.image:
    //       multipartFile = await http.MultipartFile.fromPath(
    //         'image',
    //         filePath!,
    //         contentType: contentType,
    //       );
    //       break;
    //     case ContentType.pdf:
    //       multipartFile = await http.MultipartFile.fromPath(
    //         'pdf',
    //         filePath!,
    //         contentType: contentType,
    //       );
    //       break;
    //   }
    //
    //   request.files.add(multipartFile);
    //
    //   final response = await request.send();
    //
    //   final contentLength = response.contentLength ?? file.size;
    //
    //   int uploadedBytes = 0;
    //
    //   await for (List<int> chunk in response.stream) {
    //     uploadedBytes += chunk.length;
    //     final progress = (uploadedBytes / contentLength) * 100;
    //     yield UploadData.uploading(progress);
    //
    //     if (response.statusCode == 200) {
    //       final responseObj = await http.Response.fromStream(response);
    //       // todo: Extract url from response
    //       yield UploadData.uploaded(responseObj.body);
    //     } else {
    //       yield const UploadData.error(UploadFailure());
    //     }
    //   }
    // } catch (e) {
    //   yield const UploadData.error(UploadFailure());
    // }
  }
}
