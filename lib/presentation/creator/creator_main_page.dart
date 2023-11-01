import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/auth/lumi_user.dart';
import '../../application/creator/course/crt_course_provider.dart';
import '../core/routes/app_router.dart';

@RoutePage()
class CreatorMainPage extends ConsumerStatefulWidget {
  final LumiCreator creator;

  const CreatorMainPage({required this.creator, super.key});

  @override
  ConsumerState<CreatorMainPage> createState() => _CreatorMainPageState();
}

class _CreatorMainPageState extends ConsumerState<CreatorMainPage> {
  @override
  void initState() {
    super.initState();

    Future(
      () => ref.read(creatorCourseProvider.notifier).fetchAllCourses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        CreatorHomeRoute(creator: widget.creator),
        CreatorProfileRoute(creator: widget.creator),
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
