import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../domain/course/lumi_course_type_wrapper.dart';

@RoutePage()
class AddCurriculumPage extends StatelessWidget {
  final LumiCourseTypeWrapper courseWrapper;

  const AddCurriculumPage({required this.courseWrapper, super.key});

  @override
  Widget build(BuildContext context) {
    final course = courseWrapper.course;
    final curriculum = courseWrapper.curriculum;

    // curriculum.sections!.sort((a, b) => a.templateId!.compareTo(b.templateId!));
    // curriculum.sections!.forEach((section) {
    //   section.lessons!.sort(
    //     (a, b) => a.order!.compareTo(b.order!),
    //   );
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Curriculum Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("${course.courseName}"),
            SizedBox(height: 12),
            // Preview Media Container
            // use course.previewVideoUrl
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.all(12),
              color: Colors.red,
            ),
            Text("${course.description}"),
            SizedBox(height: 12),

            Text("Add Course Contents"),

            ...[
              ...curriculum.sections!
                  .map(
                    (section) => ExpansionTile(
                      title: Text("${section.title}"),
                      children: [
                        ...section.lessons!
                            .map(
                              (lesson) => ListTile(
                                title: Text("${lesson.title}"),
                                subtitle: Text("${lesson.description}"),
                              ),
                            )
                            .toList(),
                        TextButton(
                          onPressed: () {},
                          child: Text("Add New Lesson"),
                        ),
                      ],
                    ),
                  )
                  .toList(),
              TextButton(
                onPressed: () {
                  showSectionCreationDialog(context);
                },
                child: Text("Add New Section"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

Future showSectionCreationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Add Section"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Section Title",
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Section Description",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {},
          child: Text("Add"),
        ),
      ],
    ),
  );
}
