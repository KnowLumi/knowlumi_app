import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/auth/lumi_user.dart';
import '../../auth/pages/register_page.dart';
import '../../auth/pages/select_topics_page.dart';
import '../../auth/pages/sign_in_page.dart';
import '../../creator/home/pages/creator_home_page.dart';
import '../../student/home/pages/student_home_page.dart';
import '../pages/start_up.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartUpRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(
          page: RegisterRoute.page,
          children: [
            AutoRoute(page: SelectTopicsRoute.page),
          ],
        ),
        AutoRoute(page: CreatorHomeRoute.page),
        AutoRoute(page: StudentHomeRoute.page),
      ];
}
