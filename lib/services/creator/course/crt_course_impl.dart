import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../../../core/utils/cache/cache_providers.dart';
import '../../core/service_providers.dart';
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

class CrtCourseRepository implements ICrtCourseRepo {
  final ProviderRef ref;
  CrtCourseRepository(this.ref);

  Client get _client => ref.watch(httpClientProvider);
  FirebaseAuth get _auth => ref.watch(fireAuthProvider);
  CoursePref get _courseCache => ref.watch(courseCacheProvider);

  List<LumiCourseTypeWrapper> _allCourses = [];

  String get creatorId => _auth.currentUser!.uid;

  @override
  Future<Either<CrtCourseFailure, List<LumiCourseTypeWrapper>>>
      getAllCourses() async {
    return right(_allCourses);

    try {
      final response = await _client.get(
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
  Future<Either<CrtCourseFailure, LumiCourseTypeWrapper>> createCourse({
    required LumiCourse course,
    required LumiCurriculum curriculum,
  }) async {
    try {
      // ! Test //
      LumiCourseDto c = LumiCourseDto.fromDomain(course).copyWith(
        id: "id123",
        curriculumId: "123id",
        creatorId: _auth.currentUser!.uid,
      );

      LumiCurriculumDto curr =
          LumiCurriculumDto.fromDomain(curriculum).copyWith(
        id: "123id",
      );

      final wrapper = LumiCourseTypeWrapper(
        course: c.toDomain(),
        curriculum: curr.toDomain(),
      );

      _allCourses.add(wrapper);

      return right(wrapper);

      // await _courseCache.createCourse(
      //   newCourse: c.toJson(),
      //   newCurriculum: curr.toJson(),
      // );
      //
      // return right(
      //   LumiCourseTypeWrapper(
      //     course: c.toDomain(),
      //     curriculum: curr.toDomain(),
      //   ),
      // );
      // ! Test //

      final response = await _client.post(
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

        // return none();
      } else {
        return left(const CrtCourseFailure.serverFailure());
      }
    } catch (e) {
      print(e.toString());
      return left(const CrtCourseFailure.serverFailure());
    }
  }

  @override
  Future<Option<CrtCourseFailure>> updateCourse({
    LumiCourse? course,
    LumiCurriculum? curriculum,
  }) async {
    try {
      // ! Test //
      await _courseCache.updateCourse(
        courseId: course?.id,
        updatedCourse:
            course != null ? LumiCourseDto.fromDomain(course).toJson() : null,
        curriculumId: curriculum?.id,
        updatedCurriculum: curriculum != null
            ? LumiCurriculumDto.fromDomain(curriculum).toJson()
            : null,
      );

      return none();
      // ! Test //

      final response = await _client.put(
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
      // ! Test //
      _allCourses.removeWhere((element) => element.course.id == courseId);
      print(_allCourses.length);

      return none();
      //! Test //

      final response = await _client.delete(
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
