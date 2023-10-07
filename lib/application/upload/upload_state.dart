part of 'upload_bloc.dart';

@freezed
class UploadState with _$UploadState {
  const factory UploadState.initial() = Initial;

  const factory UploadState.imagePicked(PlatformFile file) = ImagePicked;
  const factory UploadState.videoPicked(PlatformFile file) = VideoPicked;
  const factory UploadState.pdfPicked(PlatformFile file) = PdfPicked;

  const factory UploadState.pickCancelled() = PickCancelled;
  const factory UploadState.pickFailed(String message) = PickFailed;

  const factory UploadState.uploadInProgress(double progress) =
      UploadInProgress;
  const factory UploadState.uploadFailed(String message) = UploadFailed;
  const factory UploadState.contentUploaded(String url) = ContentUploaded;
}
