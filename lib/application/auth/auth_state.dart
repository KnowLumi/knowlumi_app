part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.unAuthenticated() = UnAuthenticated;
  const factory AuthState.toRegister() = ToRegister;
  const factory AuthState.student({required LumiStudent user}) = Student;
  const factory AuthState.creator({required LumiCreator user}) = Creator;
  const factory AuthState.failure(String message) = Failure;
}
