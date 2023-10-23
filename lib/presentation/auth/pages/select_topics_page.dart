import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/app_router.dart';
import '../../../application/auth/auth_bloc.dart';
import '../../../domain/auth/lumi_user.dart';

@RoutePage()
class SelectTopicsPage extends StatelessWidget {
  const SelectTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
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
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  AuthEvent.registerUser(
                    role: UserType.student,
                    interestedTopics: ['Technology', 'Science'],
                  ),
                );
              },
              child: Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
