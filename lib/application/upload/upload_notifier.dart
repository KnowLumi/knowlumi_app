import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_notifier.freezed.dart';

@freezed
class UploadNotifier with _$UploadNotifier {
  const factory UploadNotifier.initial() = Initial;

  const factory UploadNotifier.imagePicked(PlatformFile file) = ImagePicked;
  const factory UploadNotifier.videoPicked(PlatformFile file) = VideoPicked;
  const factory UploadNotifier.pdfPicked(PlatformFile file) = PdfPicked;

  const factory UploadNotifier.pickCancelled() = PickCancelled;
  const factory UploadNotifier.pickFailed(String message) = PickFailed;

  const factory UploadNotifier.uploadInProgress(double progress) =
      UploadInProgress;
  const factory UploadNotifier.uploadFailed(String message) = UploadFailed;
  const factory UploadNotifier.contentUploaded(String url) = ContentUploaded;
}
