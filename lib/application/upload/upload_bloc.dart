import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:knowlumi_app/domain/course/lumi_curriculum.dart';
import 'package:knowlumi_app/domain/upload/file_pick_failure.dart';
import 'package:knowlumi_app/domain/upload/upload_data.dart';

import '../../domain/upload/i_upload_repo.dart';
import '../../domain/upload/upload_failure.dart';

part 'upload_event.dart';
part 'upload_state.dart';
part 'upload_bloc.freezed.dart';

@injectable
class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final IUploadRepo _uploadRepo;

  UploadBloc(this._uploadRepo) : super(const UploadState.initial()) {
    on<PickImage>((event, emit) async {
      final failureOrFile = await _uploadRepo.pickContent(ContentType.image);

      if (failureOrFile.isRight()) {
        final optionReturn = failureOrFile.getOrElse(() => none());

        emit(
          optionReturn.fold(
            () => const UploadState.pickCancelled(),
            (file) => UploadState.imagePicked(file.file),
          ),
        );
      }
    });

    on<PickVideo>((event, emit) async {
      final failureOrFile = await _uploadRepo.pickContent(ContentType.image);

      failureOrFile.fold(
        (failure) => switch (failure) {
          ExceedsMaxSize() => const UploadState.pickFailed("Max Size Exceeded"),
        },
        (fileOrNone) => fileOrNone.fold(
          () => const UploadState.pickCancelled(),
          (file) => UploadState.videoPicked(file.file),
        ),
      );
    });

    on<PickPdf>((event, emit) async {
      final failureOrFile = await _uploadRepo.pickContent(ContentType.pdf);

      if (failureOrFile.isRight()) {
        final optionReturn = failureOrFile.getOrElse(() => none());

        emit(
          optionReturn.fold(
            () => const UploadState.pickCancelled(),
            (file) => UploadState.pdfPicked(file.file),
          ),
        );
      }
    });

    on<UploadImage>((event, emit) async {
      await for (var response in _uploadRepo.uploadContent(
        type: ContentType.image,
        file: event.file,
      )) {
        emit(
          response.when(
            uploading: UploadState.uploadInProgress,
            uploaded: UploadState.contentUploaded,
            error: (failure) => switch (failure) {
              Failed() => const UploadState.uploadFailed("Failed to Upload")
            },
          ),
        );
      }
    });

    on<UploadVideo>((event, emit) async {
      await for (var response in _uploadRepo.uploadContent(
        type: ContentType.video,
        file: event.file,
      )) {
        emit(
          response.when(
            uploading: UploadState.uploadInProgress,
            uploaded: UploadState.contentUploaded,
            error: (failure) => switch (failure) {
              Failed() => const UploadState.uploadFailed("Failed to Upload")
            },
          ),
        );
      }
    });

    on<UploadPdf>((event, emit) async {
      await for (var response in _uploadRepo.uploadContent(
        type: ContentType.pdf,
        file: event.file,
      )) {
        emit(
          response.when(
            uploading: UploadState.uploadInProgress,
            uploaded: UploadState.contentUploaded,
            error: (failure) => switch (failure) {
              Failed() => const UploadState.uploadFailed("Failed to Upload")
            },
          ),
        );
      }
    });
  }
}
