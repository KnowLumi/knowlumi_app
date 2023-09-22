part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authCheckRequested() = AuthCheckRequested;
  const factory AuthEvent.signInUsingGoogle() = SignInUsingGoogle;
  const factory AuthEvent.registerUser({
    required UserType role,
  }) = RegisterUser;
  const factory AuthEvent.signOut() = SignOut;
}
