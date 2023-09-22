import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knowlumi_app/domain/auth/lumi_user.dart';

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
        (user) {
          if (user is NotRegistered) {
            return const AuthState.toRegister();
          } else {
            return AuthState.success(
              role: getUserType(user),
              user: user,
            );
          }
        },
      ));
    });
    on<SignInUsingGoogle>((event, emit) async {
      emit(const Loading());
      final failureOrUser = await _authRepo.signInUsingGoogle();

      emit(failureOrUser.fold(
        (failure) => failure.when(
          serverError: () => const AuthState.failure("message"),
          cancelledByUser: () => const AuthState.failure("message"),
        ),
        (user) {
          if (user is NotRegistered) {
            return const AuthState.toRegister();
          } else {
            return AuthState.success(
              role: getUserType(user),
              user: user,
            );
          }
        },
      ));
    });
    on<RegisterUser>((event, emit) async {
      emit(const Loading());

      final failureOrUser = await _authRepo.registerUser(role: event.role);

      emit(
        failureOrUser.fold(
          (failure) => failure.maybeWhen(
            orElse: () => const AuthState.failure("message"),
          ),
          (user) => AuthState.success(
            role: event.role,
            user: user,
          ),
        ),
      );
    });
    on<SignOut>((event, emit) async {
      await _authRepo.signOut();
      emit(const AuthState.unAuthenticated());
    });
  }

  UserType getUserType(LumiUser lumiUser) {
    if (lumiUser is LumiCreator) {
      return UserType.creator;
    } else {
      return UserType.student;
    }
  }
}
