import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/creator/course/crt_course_bloc.dart';
import '../../application/upload/upload_bloc.dart';
import '../../../../domain/auth/lumi_user.dart';
import '../../injection.dart';
import '../core/routes/app_router.dart';

@RoutePage()
class CreatorMainPage extends StatelessWidget {
  final LumiCreator creator;

  const CreatorMainPage({required this.creator, super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        CreatorHomeRoute(creator: creator),
        CreatorProfileRoute(creator: creator),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person),
            ),
          ],
        );
      },
    );
  }
}
