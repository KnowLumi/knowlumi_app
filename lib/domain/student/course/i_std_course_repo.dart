import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowlumi_app/services/student/course/std_course_impl.dart';

import '../../course/lumi_course_type_wrapper.dart';
import 'std_course_failures.dart';

final stdCourseRepoProvider =
    Provider<IStdCourseRepo>((ref) => StdCourseRepository(ref));

abstract interface class IStdCourseRepo {
  Future<Either<StdCourseFailure, List<LumiCourseTypeWrapper>>>
      getRecommendedCourses();
  Future<Either<StdCourseFailure, List<LumiCourseTypeWrapper>>>
      getPurchasedCourses();
  Future<Either<StdCourseFailure, List<LumiCourseTypeWrapper>>>
      getWishListedCourses();
  Future<Option<StdCourseFailure>> purchaseCourse(String courseId);
}
