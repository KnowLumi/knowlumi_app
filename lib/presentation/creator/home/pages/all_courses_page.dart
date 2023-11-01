import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/creator/course/crt_course_provider.dart';
import '../../../core/routes/app_router.dart';
import '../../../../domain/course/lumi_course_type_wrapper.dart';

@RoutePage()
class AllCoursesPage extends ConsumerWidget {
  final List<LumiCourseTypeWrapper> allCoursesWrapper;

  const AllCoursesPage({required this.allCoursesWrapper, super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(
      creatorCourseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          deleted: () {
            ref.read(creatorCourseProvider.notifier).fetchAllCourses();
          },
        );
      },
    );

    return ListView.builder(
      itemCount: allCoursesWrapper.length,
      itemBuilder: (context, index) {
        final courseWrapper = allCoursesWrapper[index];
        final course = courseWrapper.course;
        final curriculum = courseWrapper.curriculum;

        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${course.courseName}"),
                  PopupMenuButton(
                    onSelected: (option) {
                      if (option == 'Edit') {
                        context.router.push(
                          AddCurriculumRoute(courseWrapper: courseWrapper),
                        );
                      } else if (option == 'Delete') {
                        ref.read(creatorCourseProvider.notifier).deleteCourse(
                              courseId: course.id!,
                              curriculumId: curriculum.id!,
                            );
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Edit"),
                        value: 'Edit',
                      ),
                      PopupMenuItem(
                        child: Text("Delete"),
                        value: 'Delete',
                      ),
                    ],
                  ),
                ],
              ),
              Text("${course.description}"),
            ],
          ),
        );
      },
    );
  }
}
