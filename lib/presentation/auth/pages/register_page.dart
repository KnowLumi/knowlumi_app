import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../../domain/auth/lumi_user.dart';
import '../../core/routes/app_router.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          creator: (creator) {
            context.router.replace(
              CreatorMainRoute(creator: creator),
            );
          },

          // todo: Handle Creator Register Failure
          failure: (message) {},
        );
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthEvent.registerUser(role: UserType.creator),
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
      ),
    );
  }
}
