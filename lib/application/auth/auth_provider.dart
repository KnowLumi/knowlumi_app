import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/i_auth_repo.dart';
import '../../domain/auth/lumi_user.dart';
import 'auth_notifier.dart';

part 'auth_provider.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  AuthNotifier build() {
    return const AuthNotifier.initial();
  }

  IAuthRepo get _authRepo => ref.watch(authRepoProvider);

  Future<void> authCheckRequested() async {
    state = const AuthNotifier.loading();

    final currentUser = await _authRepo.getSignedInUser();

    state = currentUser.fold(
      () => const AuthNotifier.unAuthenticated(),
      (user) => _switchUserState(user),
    );
  }

  Future<void> signInUsingGoogle() async {
    state = const AuthNotifier.loading();

    final failureOrUser = await _authRepo.signInUsingGoogle();

    state = failureOrUser.fold(
      (failure) => switch (failure) {
        ServerError() => const AuthNotifier.failure("message"),
        CancelledByUser() => const AuthNotifier.failure("message"),
      },
      (user) => _switchUserState(user),
    );
  }

  Future<void> registerUser({
    required UserType role,
    List<String>? interestedTopics,
  }) async {
    state = const AuthNotifier.loading();

    final failureOrUser = await _authRepo.registerUser(
      role: role,
      interestedTopics: interestedTopics,
    );

    state = failureOrUser.fold(
      (failure) => switch (failure) {
        ServerError() ||
        CancelledByUser() =>
          const AuthNotifier.failure("message"),
      },
      (user) => _switchUserState(user),
    );
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
    state = const AuthNotifier.unAuthenticated();
  }

  AuthNotifier _switchUserState(LumiUser user) {
    return switch (user) {
      NotRegistered() => const AuthNotifier.toRegister(),
      LumiCreator creator => AuthNotifier.creator(user: creator),
      LumiStudent student => AuthNotifier.student(user: student)
    };
  }
}
