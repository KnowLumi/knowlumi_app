import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          //todo: Nav to register Page
          toRegister: () => null,
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
