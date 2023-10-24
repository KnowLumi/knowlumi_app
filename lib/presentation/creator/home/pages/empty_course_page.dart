import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/app_router.dart';

@RoutePage()
class EmptyCoursePage extends StatelessWidget {
  const EmptyCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("No Courses hey"),
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
