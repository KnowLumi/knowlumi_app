import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

enum UserType {
  creator,
  student,
  admin,
}

@freezed
class User with _$User {
  const factory User({
    required String uid,
    required UserType userType,
  }) = _User;
}
