import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowlumi_app/application/auth/auth_bloc.dart';
import 'package:knowlumi_app/presentation/auth/pages/register_page.dart';
import 'package:knowlumi_app/presentation/auth/pages/sign_in_page.dart';

class StartUpPage extends StatelessWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          failure: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            unAuthenticated: () => const SignInPage(),
            toRegister: () => const RegisterPage(),
            creator: (creator) => Container(),
            student: (student) => Container(),
          ),
        );
      },
    );
  }
}
