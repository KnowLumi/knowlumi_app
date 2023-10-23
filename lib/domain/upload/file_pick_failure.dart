import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_pick_failure.freezed.dart';

@freezed
sealed class FilePickFailure with _$FilePickFailure {
  const factory FilePickFailure.exceedsMaxSize() = ExceedsMaxSize;
}
