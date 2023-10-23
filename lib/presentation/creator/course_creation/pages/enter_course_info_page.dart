import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_router.dart';
import '../../../../application/creator/course/crt_course_bloc.dart';
import '../../../../domain/course/lumi_course.dart';

@RoutePage()
class EnterCourseInfoPage extends StatelessWidget {
  EnterCourseInfoPage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CrtCourseBloc, CrtCourseState>(
      listener: (context, state) {
        state.maybeWhen(
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
      builder: (context, state) {
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
                Builder(
                  builder: (context) {
                    bool isLoading = context.select<CrtCourseBloc, bool>(
                      (CrtCourseBloc bloc) => bloc.state is Loading,
                    );

                    return ElevatedButton(
                      onPressed: isLoading
                          ? () {}
                          : () {
                              BlocProvider.of<CrtCourseBloc>(context).add(
                                CrtCourseEvent.createCourse(
                                  course: LumiCourse(
                                    courseName: _titleController.value.text,
                                    description: _descController.value.text,
                                  ),
                                ),
                              );
                            },
                      child: BlocBuilder<CrtCourseBloc, CrtCourseState>(
                        builder: (context, state) => state.maybeWhen(
                          orElse: () => Text("Create"),
                          loading: () => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
