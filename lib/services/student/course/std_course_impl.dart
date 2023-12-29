import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../../../domain/course/lumi_course_type_wrapper.dart';
import '../../../domain/student/course/i_std_course_repo.dart';
import '../../../domain/student/course/std_course_failures.dart';
import '../../core/service_providers.dart';
import '../../course_dto/lumi_course_dto.dart';
import '../../course_dto/lumi_curriculum_dto.dart';

class StdCourseRepository implements IStdCourseRepo {
  final ProviderRef ref;
  StdCourseRepository(this.ref);

  final List<LumiCourseTypeWrapper> _purchasedCourses = [];
  final List<LumiCourseTypeWrapper> _recommendedCourses = [];
  final List<LumiCourseTypeWrapper> _wishListedCourses = [];

  Client get _client => ref.watch(httpClientProvider);
  FirebaseAuth get _auth => ref.watch(fireAuthProvider);

  List<String> get _purchasedCourseIds => [];
  List<String> get _wishListedCourseIds => [];

  String get creatorId => _auth.currentUser!.uid;

  @override
  Future<Either<StdCourseFailure, List<LumiCourseTypeWrapper>>>
      getRecommendedCourses() async {
    // * GetAllCoursesByIds(List<String> ids)
    try {
      final response = await _client.get(
        Uri.parse("url"),
      );

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final coursesMap = resBody['courseKey'] as List<Map<String, dynamic>>;
        final curriculumMap = resBody['k'] as List<Map<String, dynamic>>;

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

          _recommendedCourses.add(
            LumiCourseTypeWrapper(
              course: course.toDomain(),
              curriculum: respectiveCurr.toDomain(),
            ),
          );
        }

        return right(_recommendedCourses);
      } else {
        return left(const StdCourseFailure.serverFailure());
      }
    } catch (e) {
      return left(const StdCourseFailure.serverFailure());
    }
  }

  @override
  Future<Either<StdCourseFailure, List<LumiCourseTypeWrapper>>>
      getPurchasedCourses() async {
    _purchasedCourses.addAll(_recommendedCourses
        .where(
          (element) => _purchasedCourseIds.contains(element.course.id),
        )
        .toList());

    return right(_purchasedCourses);
  }

  @override
  Future<Either<StdCourseFailure, List<LumiCourseTypeWrapper>>>
      getWishListedCourses() async {
    _purchasedCourses.addAll(_recommendedCourses
        .where(
          (element) => _wishListedCourseIds.contains(element.course.id),
        )
        .toList());

    return right(_wishListedCourses);
  }

  @override
  Future<Option<StdCourseFailure>> purchaseCourse(String courseId) {
    // TODO: implement purchaseCourse
    throw UnimplementedError();
  }
}
