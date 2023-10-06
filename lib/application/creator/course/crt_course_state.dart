part of 'crt_course_bloc.dart';

@freezed
class CrtCourseState with _$CrtCourseState {
  const factory CrtCourseState.initial() = Initial;
  const factory CrtCourseState.loading() = Loading;
  const factory CrtCourseState.failure(String message) = Failure;
  const factory CrtCourseState.noCourse() = NoCourse;
  const factory CrtCourseState.allCourse(
    List<LumiCourseTypeWrapper> courseWrappers,
  ) = AllCourse;
  const factory CrtCourseState.created() = Created;
  const factory CrtCourseState.updated() = Updated;
  const factory CrtCourseState.deleted() = Deleted;
}
