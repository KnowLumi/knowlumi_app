import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/course/lumi_course_type_wrapper.dart';
import '../../../domain/course/lumi_course.dart';
import '../../../domain/course/lumi_curriculum.dart';
import '../../../domain/creator/course/crt_course_failures.dart';
import '../../../domain/creator/course/i_crt_course_repo.dart';

part 'crt_course_event.dart';
part 'crt_course_state.dart';
part 'crt_course_bloc.freezed.dart';

@injectable
class CrtCourseBloc extends Bloc<CrtCourseEvent, CrtCourseState> {
  final ICrtCourseRepo _courseRepo;

  CrtCourseBloc(this._courseRepo) : super(const CrtCourseState.initial()) {
    on<FetchAllCourses>((event, emit) async {
      emit(const Loading());

      final failureOrCourses = await _courseRepo.getAllCourses();

      emit(
        failureOrCourses.fold(
          (failure) => switch (failure) {
            ServerFailure() => const CrtCourseState.failure("message"),
          },
          (courses) {
            if (courses.isEmpty) {
              return const CrtCourseState.noCourse();
            }

            return CrtCourseState.allCourse(courses);
          },
        ),
      );
    });

    on<CreateCourse>((event, emit) async {
      emit(const Loading());

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
        tmsCreate: DateTime.now().millisecondsSinceEpoch,
        tmsUpdate: DateTime.now().millisecondsSinceEpoch,
      );

      final failureOrNone = await _courseRepo.createCourse(
        course: event.course,
        curriculum: initialCurriculum,
      );

      emit(
        failureOrNone.fold(
          () => const CrtCourseState.created(),
          (failure) => switch (failure) {
            ServerFailure() => const CrtCourseState.failure("Failed to create"),
          },
        ),
      );
    });

    on<UpdateCourse>((event, emit) async {
      emit(const Loading());

      final failureOrNone = await _courseRepo.updateCourse(
        course: event.course,
        curriculum: event.curriculum,
      );

      emit(
        failureOrNone.fold(
          () => const CrtCourseState.updated(),
          (failure) => switch (failure) {
            ServerFailure() => const CrtCourseState.failure("Failed to update"),
          },
        ),
      );
    });

    on<DeleteCourse>((event, emit) async {
      emit(const Loading());

      final failureOrNone = await _courseRepo.deleteCourse(
        courseId: event.courseId,
        curriculumId: event.curriculumId,
      );

      emit(
        failureOrNone.fold(
          () => const CrtCourseState.deleted(),
          (failure) => switch (failure) {
            ServerFailure() => const CrtCourseState.failure("Failed to delete"),
          },
        ),
      );
    });
  }
}
