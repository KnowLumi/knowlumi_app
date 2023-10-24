import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/date_time_utils.dart';
import '../../../domain/course/lumi_curriculum.dart';
import '../../../domain/creator/course/crt_course_failures.dart';
import '../../../domain/creator/course/i_crt_course_repo.dart';
import '../../../domain/course/lumi_course.dart';
import 'crt_course_notifier.dart';

part 'crt_course_provider.g.dart';

@riverpod
class CreatorCourse extends _$CreatorCourse {
  @override
  CrtCourseNotifier build() {
    return const CrtCourseNotifier.initial();
  }

  ICrtCourseRepo get _courseRepo => ref.watch(crtCourseRepoProvider);

  Future<void> fetchAllCourses() async {
    state = const CrtCourseNotifier.loading();

    final failureOrCourses = await _courseRepo.getAllCourses();

    state = failureOrCourses.fold(
      (failure) => switch (failure) {
        ServerFailure() => const CrtCourseNotifier.failure("message"),
      },
      (courses) {
        if (courses.isEmpty) {
          return const CrtCourseNotifier.noCourse();
        }
        return CrtCourseNotifier.allCourse(courses);
      },
    );
  }

  Future<void> createCourse(LumiCourse course) async {
    state = const CrtCourseNotifier.loading();

    final initialCurriculum = LumiCurriculum(
      sections: [
        const Section(
          title: "Section 1",
          subtitle: "Section Description",
          templateId: 0,
          lessons: [
            Lesson(
              title: "Lesson 1",
              description: "Lesson Description",
              contentType: null,
              url: null,
              order: 0,
            ),
          ],
        ),
      ],
      tmsCreate: currentTms,
      tmsUpdate: currentTms,
    );

    final failureOrNone = await _courseRepo.createCourse(
      course: course,
      curriculum: initialCurriculum,
    );

    state = failureOrNone.fold(
      (failure) => switch (failure) {
        ServerFailure() => const CrtCourseNotifier.failure("Failed to create"),
      },
      (courseWrapper) => CrtCourseNotifier.created(courseWrapper),
    );
  }

  Future<void> updateCourse({
    required LumiCourse course,
    required LumiCurriculum curriculum,
  }) async {
    state = const CrtCourseNotifier.loading();

    final failureOrNone = await _courseRepo.updateCourse(
      course: course,
      curriculum: curriculum,
    );

    state = failureOrNone.fold(
      () => const CrtCourseNotifier.updated(),
      (failure) => switch (failure) {
        ServerFailure() => const CrtCourseNotifier.failure("Failed to update"),
      },
    );
  }

  Future<void> deleteCourse({
    required String courseId,
    required String curriculumId,
  }) async {
    state = const CrtCourseNotifier.loading();

    final failureOrNone = await _courseRepo.deleteCourse(
      courseId: courseId,
      curriculumId: curriculumId,
    );

    state = failureOrNone.fold(
      () => const CrtCourseNotifier.deleted(),
      (failure) => switch (failure) {
        ServerFailure() => const CrtCourseNotifier.failure("Failed to delete"),
      },
    );
  }
}
