import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/course/lumi_curriculum.dart';
import '../../domain/upload/file_pick_failure.dart';
import '../../domain/upload/upload_failure.dart';
import '../../domain/upload/i_upload_repo.dart';
import 'upload_notifier.dart';

part 'upload_provider.g.dart';

@riverpod
class Upload extends _$Upload {
  @override
  UploadNotifier build() {
    return const UploadNotifier.initial();
  }

  IUploadRepo get _uploadRepo => ref.watch(uploadRepoProvider);

  Future<void> pickImage() async {
    final failureOrFile = await _uploadRepo.pickContent(ContentType.image);

    if (failureOrFile.isRight()) {
      final optionReturn = failureOrFile.getOrElse(() => none());

      state = optionReturn.fold(
        () => const UploadNotifier.pickCancelled(),
        (file) => UploadNotifier.imagePicked(file.file),
      );
    }
  }

  Future<void> pickVideo() async {
    final failureOrFile = await _uploadRepo.pickContent(ContentType.image);

    state = failureOrFile.fold(
      (failure) => switch (failure) {
        ExceedsMaxSize() =>
          const UploadNotifier.pickFailed("Max Size Exceeded"),
      },
      (fileOrNone) => fileOrNone.fold(
        () => const UploadNotifier.pickCancelled(),
        (file) => UploadNotifier.videoPicked(file.file),
      ),
    );
  }

  Future<void> pickPdf() async {
    final failureOrFile = await _uploadRepo.pickContent(ContentType.pdf);

    if (failureOrFile.isRight()) {
      final optionReturn = failureOrFile.getOrElse(() => none());

      state = optionReturn.fold(
        () => const UploadNotifier.pickCancelled(),
        (file) => UploadNotifier.pdfPicked(file.file),
      );
    }
  }

  Future<void> uploadImage(PlatformFile file) async {
    await for (var response in _uploadRepo.uploadContent(
      type: ContentType.image,
      file: file,
    )) {
      state = response.when(
        uploading: UploadNotifier.uploadInProgress,
        uploaded: UploadNotifier.contentUploaded,
        error: (failure) => switch (failure) {
          Failed() => const UploadNotifier.uploadFailed("Failed to Upload")
        },
      );
    }
  }

  Future<void> uploadVideo(PlatformFile file) async {
    await for (var response in _uploadRepo.uploadContent(
      type: ContentType.video,
      file: file,
    )) {
      state = response.when(
        uploading: UploadNotifier.uploadInProgress,
        uploaded: UploadNotifier.contentUploaded,
        error: (failure) => switch (failure) {
          Failed() => const UploadNotifier.uploadFailed("Failed to Upload")
        },
      );
    }
  }

  Future<void> uploadPdf(PlatformFile file) async {
    await for (var response in _uploadRepo.uploadContent(
      type: ContentType.pdf,
      file: file,
    )) {
      state = response.when(
        uploading: UploadNotifier.uploadInProgress,
        uploaded: UploadNotifier.contentUploaded,
        error: (failure) => switch (failure) {
          Failed() => const UploadNotifier.uploadFailed("Failed to Upload")
        },
      );
    }
  }
}
