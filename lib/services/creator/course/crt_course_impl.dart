import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/course/lumi_course_type_wrapper.dart';
import '../../course_dto/lumi_course_dto.dart';
import '../../course_dto/lumi_curriculum_dto.dart';
import '../../../core/utils/cache/course_pref.dart';
import '../../../domain/course/lumi_course.dart';
import '../../../domain/course/lumi_curriculum.dart';
import '../../../domain/creator/course/crt_course_failures.dart';
import '../../../domain/creator/course/i_crt_course_repo.dart';

const String courseKey = 'lumiCourses';
const String curriculumKey = 'lumiCurriculum';

@LazySingleton(as: ICrtCourseRepo)
class CrtCourseRepository implements ICrtCourseRepo {
  final Client _httpClient;
  final CoursePref _courseCache;
  final FirebaseAuth _firebaseAuth;

  CrtCourseRepository(this._httpClient, this._courseCache, this._firebaseAuth);

  String get creatorId => _firebaseAuth.currentUser!.uid;

  @override
  Future<Either<CrtCourseFailure, List<LumiCourseTypeWrapper>>>
      getAllCourses() async {
    final cacheData = _courseCache.getAllCourses();

    if (cacheData.$1.isNotEmpty && cacheData.$2.isNotEmpty) {
      final cachedCoursesMap = cacheData.$1;
      final cachedCurrMap = cacheData.$2;

      final listOfCoursesAndCurr = _mapCourseCurrMapsToList(
        coursesMap: cachedCoursesMap,
        curriculumMap: cachedCurrMap,
      );

      return right(listOfCoursesAndCurr);
    }

    try {
      final response = await _httpClient.get(
        Uri.parse("url"),
        headers: {},
      );

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final coursesMap = resBody[courseKey] as List<Map<String, dynamic>>;
        final curriculumMap =
            resBody[curriculumKey] as List<Map<String, dynamic>>;

        await _courseCache.setAllCourses(
          courses: coursesMap,
          curriculums: curriculumMap,
        );

        final listOfCoursesAndCurr = _mapCourseCurrMapsToList(
          coursesMap: coursesMap,
          curriculumMap: curriculumMap,
        );

        return right(listOfCoursesAndCurr);
      } else {
        return left(const CrtCourseFailure.serverFailure());
      }
    } catch (e) {
      return left(const CrtCourseFailure.serverFailure());
    }
  }

  List<LumiCourseTypeWrapper> _mapCourseCurrMapsToList({
    required List<Map<String, dynamic>> coursesMap,
    required List<Map<String, dynamic>> curriculumMap,
  }) {
    final listOfCoursesAndCurr = <LumiCourseTypeWrapper>[];

    final courseDtos = coursesMap
        .map(
          (e) => LumiCourseDto.fromJson(e),
        )
        .toList();
    final currDtos = curriculumMap
        .map(
          (e) => LumiCurriculumDto.fromJson(e),
        )
        .toList();

    for (var course in courseDtos) {
      final respectiveCurr = currDtos.firstWhere(
        (element) => course.curriculumId == element.id,
      );

      listOfCoursesAndCurr.add(
        LumiCourseTypeWrapper(
          course: course.toDomain(),
          curriculum: respectiveCurr.toDomain(),
        ),
      );
    }

    return listOfCoursesAndCurr;
  }

  @override
  Future<Option<CrtCourseFailure>> createCourse({
    required LumiCourse course,
    required LumiCurriculum curriculum,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse("uri"),
        headers: {},
        body: {},
      );

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);

        final coursesMap = resBody[courseKey] as Map<String, dynamic>;
        final curriculumMap = resBody[curriculumKey] as Map<String, dynamic>;

        await _courseCache.createCourse(
          newCourse: coursesMap,
          newCurriculum: curriculumMap,
        );

        return none();
      } else {
        return some(const CrtCourseFailure.serverFailure());
      }
    } catch (e) {
      return some(const CrtCourseFailure.serverFailure());
    }
  }

  @override
  Future<Option<CrtCourseFailure>> updateCourse({
    LumiCourse? course,
    LumiCurriculum? curriculum,
  }) async {
    try {
      final response = await _httpClient.put(
        Uri.parse("uri"),
        headers: {},
        body: {},
      );

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);

        final coursesMap = resBody[courseKey] as Map<String, dynamic>?;
        final curriculumMap = resBody[curriculumKey] as Map<String, dynamic>?;

        await _courseCache.updateCourse(
          courseId: course?.id,
          updatedCourse: coursesMap,
          curriculumId: curriculum?.id,
          updatedCurriculum: curriculumMap,
        );

        return none();
      } else {
        return some(const CrtCourseFailure.serverFailure());
      }
    } catch (e) {
      return some(const CrtCourseFailure.serverFailure());
    }
  }

  @override
  Future<Option<CrtCourseFailure>> deleteCourse({
    required String courseId,
    required String curriculumId,
  }) async {
    try {
      final response = await _httpClient.delete(
        Uri.parse("uri"),
        headers: {},
      );

      if (response.statusCode == 200) {
        await _courseCache.deleteCourse(
          courseId: courseId,
          curriculumId: curriculumId,
        );

        return none();
      } else {
        return some(const CrtCourseFailure.serverFailure());
      }
    } catch (e) {
      return some(const CrtCourseFailure.serverFailure());
    }
  }
}
