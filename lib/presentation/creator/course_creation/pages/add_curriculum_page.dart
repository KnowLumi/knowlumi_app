import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/course/lumi_course.dart';
import '../../../../domain/course/lumi_curriculum.dart';
import '../../../../domain/course/lumi_course_type_wrapper.dart';
import '../../../core/routes/app_router.dart';
import '../widgets/section_creation_dialog.dart';
import '../widgets/save_course_dialog.dart';

final activeCourseProvider = StateProvider<LumiCourse?>((ref) => null);
final activeCurriculumProvider = StateProvider<LumiCurriculum?>((ref) => null);

@RoutePage()
class AddCurriculumPage extends ConsumerStatefulWidget {
  final LumiCourseTypeWrapper courseWrapper;

  const AddCurriculumPage({required this.courseWrapper, super.key});

  @override
  ConsumerState<AddCurriculumPage> createState() => _AddCurriculumPageState();
}

class _AddCurriculumPageState extends ConsumerState<AddCurriculumPage> {
  bool canPop = false;
  @override
  void initState() {
    super.initState();

    Future(
      () {
        ref
          ..read(activeCourseProvider.notifier)
              .update((_) => widget.courseWrapper.course)
          ..read(activeCurriculumProvider.notifier)
              .update((_) => widget.courseWrapper.curriculum);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    LumiCourse course = ref.watch(activeCourseProvider) ?? LumiCourse.empty();
    LumiCurriculum curriculum =
        ref.watch(activeCurriculumProvider) ?? LumiCurriculum.empty();

    return WillPopScope(
      onWillPop: () async {
        if (!canPop) {
          canPop = await saveCourseDialog(context, ref) ?? false;
          setState(() {});
          if (canPop && mounted) context.router.pop();
        }

        return Future.value(canPop);
      },
      child: Scaffold(
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

              ...List.generate(
                curriculum.sections!.length,
                (sectionIndex) {
                  final section = curriculum.sections![sectionIndex];

                  return ExpansionTile(
                    title: Text("${section.title}"),
                    subtitle: Text("${section.subtitle}"),
                    children: [
                      ...List.generate(
                        section.lessons!.length,
                        (lessonIndex) {
                          final lesson = section.lessons![lessonIndex];

                          return ListTile(
                            onTap: () {
                              context.router.push(
                                LessonCreationRoute(
                                  title: lesson.title ?? "",
                                  description: lesson.description ?? "",
                                  contentUrl: lesson.url ?? "",
                                  sectionIndex: sectionIndex,
                                  lessonIndex: lessonIndex,
                                ),
                              );
                            },
                            title: Text("${lesson.title}"),
                            subtitle: Text("${lesson.description}"),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          context.router.push(LessonCreationRoute(
                            sectionIndex: sectionIndex,
                          ));
                        },
                        child: Text("Add New Lesson"),
                      ),
                    ],
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  showSectionCreationDialog(
                    context: context,
                    ref: ref,
                  );
                },
                child: Text("Add New Section"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Save "),
          onPressed: () async {
            canPop = await saveCourseDialog(context, ref) ?? false;
            setState(() {});

            if (canPop && mounted) context.router.pop();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
