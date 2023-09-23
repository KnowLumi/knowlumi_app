import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/lumi_user.dart';
import '../../domain/auth/i_auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepo _authRepo;

  AuthBloc(this._authRepo) : super(const AuthState.initial()) {
    on<AuthCheckRequested>((event, emit) async {
      emit(const Loading());
      final currentUser = await _authRepo.getSignedInUser();

      emit(currentUser.fold(
        () => const AuthState.unAuthenticated(),
        (user) => _switchUserState(user),
      ));
    });

    on<SignInUsingGoogle>((event, emit) async {
      emit(const Loading());
      final failureOrUser = await _authRepo.signInUsingGoogle();

      emit(failureOrUser.fold(
        (failure) => switch (failure) {
          ServerError() => const AuthState.failure("message"),
          CancelledByUser() => const AuthState.failure("message"),
        },
        (user) => _switchUserState(user),
      ));
    });

    on<RegisterUser>((event, emit) async {
      emit(const Loading());

      final failureOrUser = await _authRepo.registerUser(role: event.role);

      emit(
        failureOrUser.fold(
          (failure) => switch (failure) {
            ServerError() ||
            CancelledByUser() =>
              const AuthState.failure("message"),
          },
          (user) => _switchUserState(user),
        ),
      );
    });

    on<SignOut>((event, emit) async {
      await _authRepo.signOut();
      emit(const AuthState.unAuthenticated());
    });
  }

  AuthState _switchUserState(LumiUser user) {
    return switch (user) {
      NotRegistered() => const AuthState.toRegister(),
      LumiCreator creator => AuthState.creator(user: creator),
      LumiStudent student => AuthState.student(user: student)
    };
  }
}
