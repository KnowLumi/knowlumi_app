import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/auth/auth_provider.dart';
import '../../core/routes/app_router.dart';
import '../../../domain/auth/lumi_user.dart';

@RoutePage()
class SelectTopicsPage extends ConsumerWidget {
  const SelectTopicsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(
      authenticationProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          student: (student) {
            context.router
              ..popUntilRoot()
              ..replace(
                StudentMainRoute(student: student),
              );
          },
          // todo: Handle Student Register Failure
          failure: (message) {},
        );
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              ref.read(authenticationProvider.notifier).registerUser(
                role: UserType.student,
                interestedTopics: ['Tech', 'Science'],
              );
            },
            child: Text("Done"),
          ),
        ],
      ),
    );
  }
}
