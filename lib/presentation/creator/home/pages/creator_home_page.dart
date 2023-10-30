import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowlumi_app/presentation/creator/home/pages/all_courses_page.dart';

import '../../../../application/creator/course/crt_course_provider.dart';
import '../../../../domain/auth/lumi_user.dart';
import '../../../core/routes/app_router.dart';
import 'empty_course_page.dart';

@RoutePage()
class CreatorHomePage extends ConsumerWidget {
  final LumiCreator creator;

  const CreatorHomePage({required this.creator, super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Courses"),
        centerTitle: true,
      ),
      body: ref.watch(creatorCourseProvider).maybeWhen(
            orElse: () => Center(
              child: CircularProgressIndicator(),
            ),
            failure: (message) => Center(
              child: Text("Failure Occured"),
            ),
            noCourse: () => EmptyCoursePage(),
            allCourse: (courses) => AllCoursesPage(allCoursesWrapper: courses),
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          context.router.push(EnterCourseInfoRoute());
        },
        label: Text("Create Course"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
