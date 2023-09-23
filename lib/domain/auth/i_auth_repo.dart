import 'package:dartz/dartz.dart';

import 'auth_failures.dart';
import 'lumi_user.dart';

abstract interface class IAuthRepo {
  Future<Option<LumiUser>> getSignedInUser();
  Future<Either<AuthFailure, LumiUser>> signInUsingGoogle();
  Future<Either<AuthFailure, LumiUser>> registerUser({
    required UserType role,
    List<String>? interestedTopics,
  });
  Future<void> signOut();
}
