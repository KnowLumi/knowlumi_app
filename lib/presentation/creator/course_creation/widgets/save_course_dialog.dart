import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/creator/course/crt_course_provider.dart';
import '../pages/add_curriculum_page.dart';

Future<bool?> saveCourseDialog(BuildContext context, WidgetRef ref) {
  final course = ref.watch(activeCourseProvider)!;
  final curriculum = ref.watch(activeCurriculumProvider)!;

  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      children: [
        ElevatedButton(
          onPressed: () {
            ref.read(creatorCourseProvider.notifier).updateCourse(
                  course: course,
                  curriculum: curriculum,
                );

            ref.read(creatorCourseProvider.notifier).fetchAllCourses();

            context.router.pop<bool>(true);
          },
          child: Text("Save as draft"),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(creatorCourseProvider.notifier).updateCourse(
                  course: course.copyWith(
                    isPublished: true,
                  ),
                  curriculum: curriculum,
                );

            ref.read(creatorCourseProvider.notifier).fetchAllCourses();

            context.router.pop(true);
          },
          child: Text("Save and "
              "Publish"),
        ),
      ],
    ),
  );
}
