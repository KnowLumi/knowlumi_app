import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/auth/lumi_user.dart';
import '../../../domain/course/lumi_course_type_wrapper.dart';
import '../../auth/pages/register_page.dart';
import '../../auth/pages/select_topics_page.dart';
import '../../auth/pages/sign_in_page.dart';
import '../../creator/course_creation/pages/add_curriculum_page.dart';
import '../../creator/course_creation/pages/enter_course_info_page.dart';
import '../../creator/course_creation/pages/lesson_creation_page.dart';
import '../../creator/creator_main_page.dart';
import '../../creator/home/pages/all_courses_page.dart';
import '../../creator/home/pages/creator_home_page.dart';
import '../../creator/home/pages/empty_course_page.dart';
import '../../creator/profile/pages/creator_profile_page.dart';
import '../../student/home/pages/student_home_page.dart';
import '../../student/student_main_page.dart';
import '../entry/start_up.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartUpRoute.page, initial: true, children: [
          AutoRoute(page: SignInRoute.page),
          AutoRoute(
            page: RegisterRoute.page,
            children: [
              AutoRoute(
                page: SelectTopicsRoute.page,
              ),
            ],
          ),

          // * Creator Pages
          AutoRoute(page: CreatorMainRoute.page),
          AutoRoute(page: CreatorHomeRoute.page),
          AutoRoute(page: CreatorProfileRoute.page),
        ]),

        AutoRoute(page: EmptyCourseRoute.page),
        AutoRoute(page: AllCoursesRoute.page),
        AutoRoute(page: EnterCourseInfoRoute.page),
        AutoRoute(page: AddCurriculumRoute.page),
        AutoRoute(page: LessonCreationRoute.page),

        // * Student Pages
        AutoRoute(page: StudentMainRoute.page),
        AutoRoute(page: StudentHomeRoute.page),
      ];
}
