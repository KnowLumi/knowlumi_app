import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/auth/lumi_user.dart';

part 'auth_notifier.freezed.dart';

@freezed
sealed class AuthNotifier with _$AuthNotifier {
  const factory AuthNotifier.initial() = _Initial;
  const factory AuthNotifier.loading() = _Loading;
  const factory AuthNotifier.unAuthenticated() = _UnAuthenticated;
  const factory AuthNotifier.toRegister() = _ToRegister;
  const factory AuthNotifier.student({required LumiStudent user}) = _Student;
  const factory AuthNotifier.creator({required LumiCreator user}) = _Creator;
  const factory AuthNotifier.failure(String message) = _Failure;
}
