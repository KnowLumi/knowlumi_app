import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EmptyCoursePage extends StatelessWidget {
  const EmptyCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("No Courses hey"),
    );
  }
}
