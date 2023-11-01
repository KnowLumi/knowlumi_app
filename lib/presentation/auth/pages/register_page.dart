import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../domain/auth/lumi_user.dart';
import '../../core/routes/app_router.dart';

@RoutePage()
class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(
      authenticationProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          creator: (creator) {
            context.router.replace(CreatorMainRoute(creator: creator));
          },

          // todo: Handle Creator Register Failure
          failure: (message) {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(authenticationProvider.notifier).registerUser(
                      role: UserType.creator,
                    );
              },
              child: Text("Creator"),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(const SelectTopicsRoute());
              },
              child: Text("Student"),
            ),
          ],
        ),
      ),
    );
  }
}
