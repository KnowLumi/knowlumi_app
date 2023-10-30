import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/course/lumi_curriculum.dart';
import 'add_curriculum_page.dart';

@RoutePage()
class LessonCreationPage extends ConsumerStatefulWidget {
  final String title;
  final String description;
  final String contentUrl;
  final int sectionIndex;
  final int? lessonIndex;

  const LessonCreationPage({
    super.key,
    this.title = '',
    this.description = '',
    this.contentUrl = '',
    required this.sectionIndex,
    this.lessonIndex,
  });

  @override
  ConsumerState<LessonCreationPage> createState() => _LessonCreationPageState();
}

class _LessonCreationPageState extends ConsumerState<LessonCreationPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final int sectionIndex;
  late final int? lessonIndex;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.title);
    _descController = TextEditingController(text: widget.description);
    sectionIndex = widget.sectionIndex;
    lessonIndex = widget.lessonIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Lesson"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text("Title"),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  label: Text("Description"),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Video"),
                  Text("Image"),
                  Text("Pdf"),
                ],
              ),
              Container(
                height: 150,
                width: double.infinity,
                color: Colors.red,
              ),
              ElevatedButton(
                onPressed: () {
                  ref.watch(activeCurriculumProvider.notifier).update((state) {
                    if (widget.lessonIndex != null) {
                      return state!.copyWith(
                        sections: state.sections!.map((section) {
                          if (state.sections!.indexOf(section) ==
                              sectionIndex) {
                            return section.copyWith(
                              lessons: section.lessons!.map((lesson) {
                                if (section.lessons!.indexOf(lesson) ==
                                    lessonIndex) {
                                  return lesson.copyWith(
                                    title: _titleController.text,
                                    description: _descController.text,
                                  );
                                }
                                return lesson;
                              }).toList(),
                            );
                          }
                          return section;
                        }).toList(),
                      );
                    } else {
                      final newLesson = Lesson(
                        order: state!.sections![sectionIndex].lessons!.length,
                        title: _titleController.text,
                        description: _descController.text,
                      );

                      return state.copyWith(
                        sections: state.sections!.map((section) {
                          if (state.sections!.indexOf(section) ==
                              sectionIndex) {
                            final updatedLessons = [
                              ...section.lessons!,
                              newLesson,
                            ];
                            return section.copyWith(lessons: updatedLessons);
                          }
                          return section;
                        }).toList(),
                      );
                    }
                  });

                  context.router.pop();
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
