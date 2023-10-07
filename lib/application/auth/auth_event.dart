part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authCheckRequested() = AuthCheckRequested;
  const factory AuthEvent.signInUsingGoogle() = SignInUsingGoogle;
  const factory AuthEvent.registerUser({
    required UserType role,
    List<String>? interestedTopics,
  }) = RegisterUser;
  const factory AuthEvent.signOut() = SignOut;
}
