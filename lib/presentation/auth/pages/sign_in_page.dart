import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/auth/auth_provider.dart';
import '../../core/routes/app_router.dart';

@RoutePage()
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(
      authenticationProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          toRegister: () => context.router.replace(const RegisterRoute()),

          //todo: Handle signIn Failure
          failure: (message) => null,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authenticationProvider.notifier).signInUsingGoogle();
          },
          child: Text("Sign In Using Google"),
        ),
      ),
    );
  }
}
