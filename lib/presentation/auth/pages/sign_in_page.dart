import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/app_router.dart';
import '../../../application/auth/auth_bloc.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},

          toRegister: () => context.router.replace(const RegisterRoute()),
          //todo: Handle signIn Failure
          failure: (message) => null,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(
                const SignInUsingGoogle(),
              );
            },
            child: Text("Sign In Using Google"),
          ),
        ),
      ),
    );
  }
}
