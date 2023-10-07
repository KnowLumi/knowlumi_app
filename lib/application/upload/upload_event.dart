part of 'upload_bloc.dart';

@freezed
class UploadEvent with _$UploadEvent {
  const factory UploadEvent.pickImage() = _PickImage;
  const factory UploadEvent.pickVideo() = _PickVideo;
  const factory UploadEvent.pickPdf() = _PickPdf;

  const factory UploadEvent.uploadImage(PlatformFile file) = _UploadImage;
  const factory UploadEvent.uploadVideo(PlatformFile file) = _UploadVideo;
  const factory UploadEvent.uploadPdf(PlatformFile file) = _UploadPdf;
}
