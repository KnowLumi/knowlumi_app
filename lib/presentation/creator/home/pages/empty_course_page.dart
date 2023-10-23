import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/creator/course/crt_course_bloc.dart';
import '../../../core/routes/app_router.dart';

@RoutePage()
class EmptyCoursePage extends StatefulWidget {
  const EmptyCoursePage({super.key});

  @override
  State<EmptyCoursePage> createState() => _EmptyCoursePageState();
}

class _EmptyCoursePageState extends State<EmptyCoursePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("No Courses hey"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.router.push(EnterCourseInfoRoute());
          print("hi");
          BlocProvider.of<CrtCourseBloc>(context)
              .add(CrtCourseEvent.fetchAllCourses());
        },
        label: Text("Create Course"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
