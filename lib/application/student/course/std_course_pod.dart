import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/course/lumi_course_type_wrapper.dart';
import '../../../domain/student/course/i_std_course_repo.dart';
import 'std_course_notifier.dart';

part 'std_course_pod.g.dart';

final purchasedCourseProvider =
    StateProvider<List<LumiCourseTypeWrapper>>((_) => []);
final wishListedCourseProvider =
    StateProvider<List<LumiCourseTypeWrapper>>((_) => []);

@riverpod
class StdCoursePod extends _$StdCoursePod {
  @override
  StdCourseNotifier build() {
    return const StdCourseNotifier.initial();
  }

  IStdCourseRepo get _courseRepo => ref.watch(stdCourseRepoProvider);

  Future<void> getRecommendedCourses() async {
    state = const StdCourseNotifier.loading();

    final failureOrCourses = await _courseRepo.getRecommendedCourses();

    state = failureOrCourses.fold(
      (failure) => const StdCourseNotifier.failure("Server Failure"),
      (courses) {
        _courseRepo
          ..getPurchasedCourses().then(
            (value) => ref.read(purchasedCourseProvider.notifier).update(
                  (_) => value.getOrElse(() => []),
                ),
          )
          ..getWishListedCourses().then(
            (value) => ref.read(wishListedCourseProvider.notifier).update(
                  (_) => value.getOrElse(() => []),
                ),
          );

        return StdCourseNotifier.recommendedCourses(courses);
      },
    );
  }

  Future<void> getPurchasedCourses() async {
    final courses = await _courseRepo.getPurchasedCourses();

    ref.read(purchasedCourseProvider.notifier).update(
          (_) => courses.getOrElse(() => []),
        );
  }

  Future<void> getWishListedCourses() async {
    final courses = await _courseRepo.getWishListedCourses();

    ref.read(wishListedCourseProvider.notifier).update(
          (_) => courses.getOrElse(() => []),
        );
  }

  Future<void> purchaseCourse(String courseId) async {}
}
