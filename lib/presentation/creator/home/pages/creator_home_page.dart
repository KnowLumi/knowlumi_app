import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/creator/course/crt_course_bloc.dart';
import '../../../../domain/auth/lumi_user.dart';
import 'empty_course_page.dart';

@RoutePage()
class CreatorHomePage extends StatelessWidget {
  final LumiCreator creator;

  const CreatorHomePage({required this.creator, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Courses"),
        centerTitle: true,
      ),
      body: BlocBuilder<CrtCourseBloc, CrtCourseState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => Center(
              child: CircularProgressIndicator(),
            ),
            failure: (message) => Center(
              child: Text("Failure Occured"),
            ),
            noCourse: () => EmptyCoursePage(),
            allCourse: (courses) => Center(
              child: Text("Got Courses"),
            ),
          );
        },
      ),
    );
  }
}
