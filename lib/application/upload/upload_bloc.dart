import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_event.dart';
part 'upload_state.dart';
part 'upload_bloc.freezed.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(const UploadState.initial()) {
    on<UploadEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
