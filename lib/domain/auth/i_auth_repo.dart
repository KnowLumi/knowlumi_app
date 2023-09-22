import 'package:dartz/dartz.dart';
import 'package:knowlumi_app/domain/auth/auth_failures.dart';
import 'package:knowlumi_app/domain/auth/lumi_user.dart';

abstract interface class IAuthRepo {
  Future<Option<LumiUser>> getSignedInUser();
  Future<Either<AuthFailure, LumiUser>> signInUsingGoogle();
  Future<Either<AuthFailure, LumiUser>> registerUser({required UserType role});
  Future<void> signOut();
}
