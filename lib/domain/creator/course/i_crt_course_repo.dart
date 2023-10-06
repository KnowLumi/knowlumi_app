import 'package:dartz/dartz.dart';
import 'package:knowlumi_app/domain/course/lumi_course_type_wrapper.dart';

import '../../course/lumi_course.dart';
import '../../course/lumi_curriculum.dart';
import 'crt_course_failures.dart';

abstract interface class ICrtCourseRepo {
  Future<Either<CrtCourseFailure, List<LumiCourseTypeWrapper>>> getAllCourses();
  Future<Option<CrtCourseFailure>> createCourse({
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
