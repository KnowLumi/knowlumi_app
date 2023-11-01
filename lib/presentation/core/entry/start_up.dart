import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/auth/auth_provider.dart';
import '../../creator/creator_main_page.dart';
import '../../auth/pages/register_page.dart';
import '../../auth/pages/sign_in_page.dart';
import '../../student/student_main_page.dart';

@RoutePage()
class StartUpPage extends ConsumerStatefulWidget {
  const StartUpPage({super.key});

  @override
  ConsumerState<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends ConsumerState<StartUpPage> {
  @override
  void initState() {
    super.initState();

    Future(
      () => ref.read(authenticationProvider.notifier).authCheckRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authenticationProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          failure: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          ),
        );
      },
    );

    return ref.watch(authenticationProvider).maybeWhen(
          orElse: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          unAuthenticated: () => const SignInPage(),
          toRegister: () => const RegisterPage(),
          student: (student) => StudentMainPage(student: student),
          creator: (creator) => CreatorMainPage(creator: creator),
          failure: (message) => const Scaffold(
            body: Center(
              child: Text("Failure Page"),
            ),
          ),
        );
  }
}
