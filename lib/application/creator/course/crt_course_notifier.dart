import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/course/lumi_course_type_wrapper.dart';

part 'crt_course_notifier.freezed.dart';

@freezed
class CrtCourseNotifier with _$CrtCourseNotifier {
  const factory CrtCourseNotifier.initial() = Initial;
  const factory CrtCourseNotifier.loading() = Loading;
  const factory CrtCourseNotifier.failure(String message) = Failure;
  const factory CrtCourseNotifier.noCourse() = NoCourse;
  const factory CrtCourseNotifier.allCourse(
    List<LumiCourseTypeWrapper> courseWrappers,
  ) = AllCourse;
  const factory CrtCourseNotifier.created(LumiCourseTypeWrapper courseWrapper) =
      Created;
  const factory CrtCourseNotifier.updated() = Updated;
  const factory CrtCourseNotifier.deleted() = Deleted;
}
