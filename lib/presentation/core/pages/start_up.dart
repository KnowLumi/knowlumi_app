import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../creator/home/pages/creator_home_page.dart';
import '../../student/home/pages/student_home_page.dart';
import '../../../application/auth/auth_bloc.dart';
import '../../auth/pages/register_page.dart';
import '../../auth/pages/sign_in_page.dart';

@RoutePage()
class StartUpPage extends StatelessWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          failure: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          ),
        );
      },
      builder: (context, state) {
        return switch (state) {
          Initial() || Loading() => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          UnAuthenticated() => const SignInPage(),
          ToRegister() => const RegisterPage(),
          Creator(user: var creator) => CreatorHomePage(creator: creator),
          Student(user: var student) => StudentHomePage(student: student),
          Failure() => const Scaffold(),
        };
      },
    );
  }
}
