import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth/auth_repository_impl.dart';
import 'auth_failures.dart';
import 'lumi_user.dart';

final authRepoProvider = Provider((ref) => AuthRepository(ref));

abstract interface class IAuthRepo {
  Future<Option<LumiUser>> getSignedInUser();
  Future<Either<AuthFailure, LumiUser>> signInUsingGoogle();
  Future<Either<AuthFailure, LumiUser>> registerUser({
    required UserType role,
    List<String>? interestedTopics,
  });
  Future<void> signOut();
}
