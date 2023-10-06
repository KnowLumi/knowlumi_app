part of 'crt_course_bloc.dart';

@freezed
class CrtCourseEvent with _$CrtCourseEvent {
  const factory CrtCourseEvent.fetchAllCourses() = FetchAllCourses;
  const factory CrtCourseEvent.createCourse({
    required LumiCourse course,
  }) = CreateCourse;
  const factory CrtCourseEvent.updateCourse({
    required LumiCourse? course,
    required LumiCurriculum? curriculum,
  }) = UpdateCourse;
  const factory CrtCourseEvent.deleteCourse({
    required String courseId,
    required String curriculumId,
  }) = DeleteCourse;
}
