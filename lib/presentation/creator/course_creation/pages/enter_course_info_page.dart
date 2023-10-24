import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/creator/course/crt_course_provider.dart';
import '../../../core/routes/app_router.dart';
import '../../../../domain/course/lumi_course.dart';

@RoutePage()
class EnterCourseInfoPage extends ConsumerWidget {
  EnterCourseInfoPage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(
      creatorCourseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          failure: (message) {
            // todo: Handle course creation failure
            print("Failure Occurred");
          },
          created: (courseWrapper) {
            context.router.push(
              AddCurriculumRoute(courseWrapper: courseWrapper),
            );
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Course Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(label: Text("Title")),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(label: Text("Description")),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ref.read(creatorCourseProvider.notifier).createCourse(
                      LumiCourse(
                        courseName: _titleController.value.text,
                        description: _descController.value.text,
                      ),
                    );
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
