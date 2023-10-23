part of 'upload_bloc.dart';

@freezed
class UploadEvent with _$UploadEvent {
  const factory UploadEvent.pickImage() = PickImage;
  const factory UploadEvent.pickVideo() = PickVideo;
  const factory UploadEvent.pickPdf() = PickPdf;

  const factory UploadEvent.uploadImage(PlatformFile file) = UploadImage;
  const factory UploadEvent.uploadVideo(PlatformFile file) = UploadVideo;
  const factory UploadEvent.uploadPdf(PlatformFile file) = UploadPdf;
}
