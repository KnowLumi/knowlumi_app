import 'package:dartz/dartz.dart';

import '../../course/lumi_course_type_wrapper.dart';
import '../../course/lumi_course.dart';
import '../../course/lumi_curriculum.dart';
import 'crt_course_failures.dart';

abstract interface class ICrtCourseRepo {
  Future<Either<CrtCourseFailure, List<LumiCourseTypeWrapper>>> getAllCourses();
  Future<Either<CrtCourseFailure, LumiCourseTypeWrapper>> createCourse({
    required LumiCourse course,
    required LumiCurriculum curriculum,
  });
  Future<Option<CrtCourseFailure>> updateCourse({
    LumiCourse? course,
    LumiCurriculum? curriculum,
  });
  Future<Option<CrtCourseFailure>> deleteCourse({
    required String courseId,
    required String curriculumId,
  });
}
