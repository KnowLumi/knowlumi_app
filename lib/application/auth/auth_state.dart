part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.success({
    required UserType role,
    required LumiUser user,
  }) = Success;
  const factory AuthState.unAuthenticated() = UnAuthenticated;
  const factory AuthState.toRegister() = ToRegister;
  const factory AuthState.failure(String message) = Failure;
}
