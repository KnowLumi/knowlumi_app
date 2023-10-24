import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';

import '../../core/utils/date_time_utils.dart';
import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/i_auth_repo.dart';
import '../../domain/auth/lumi_user.dart';
import '../core/service_providers.dart';
import 'lumi_user_dto.dart';

class AuthRepository implements IAuthRepo {
  final ProviderRef ref;
  AuthRepository(this.ref);

  FirebaseAuth get _auth => ref.watch(fireAuthProvider);
  FirebaseFirestore get _firestore => ref.watch(firestoreProvider);
  GoogleSignIn get _googleSignIn => ref.watch(googleSignInProvider);

  @override
  Future<Option<LumiUser>> getSignedInUser() async {
    final user = _auth.currentUser;

    if (user == null) return none();

    return some(await _filterUserType(user.uid));
  }

  @override
  Future<Either<AuthFailure, LumiUser>> registerUser({
    required UserType role,
    List<String>? interestedTopics,
  }) async {
    final user = _auth.currentUser!;
    final userId = user.uid;

    final userDataDocSnap =
        await _firestore.collection('LumiUserData').doc(userId).get();
    final userData = UserDataDto.fromJson(userDataDocSnap.data()!);

    try {
      switch (role) {
        case UserType.creator:
          final lumiCreator = LumiCreatorDto(
            id: userId,
            firstName: user.displayName ?? "Guest",
            email: user.email,
            photoUrl: user.photoURL,
            tmsCreate: currentTms,
            tmsUpdate: currentTms,
          );

          _firestore
            ..collection("LumiCreators").doc(userId).set(
                  lumiCreator.toJson(),
                )
            ..collection("LumiUserData").doc(userId).update(
                  userData
                      .copyWith(
                        role: 'creator',
                      )
                      .toJson(),
                );
          return right(lumiCreator.toDomain());
        case UserType.student:
          final lumiStudent = LumiStudentDto(
            id: userId,
            firstName: user.displayName ?? "Guest",
            email: user.email,
            photoUrl: user.photoURL,
            tmsCreate: currentTms,
            tmsUpdate: currentTms,
            interestedTopics: interestedTopics ?? [],
          );

          _firestore
            ..collection("LumiStudents").doc(userId).set(
                  lumiStudent.toJson(),
                )
            ..collection("LumiUserData").doc(userId).update(
                  userData
                      .copyWith(
                        role: 'student',
                      )
                      .toJson(),
                );
          return right(lumiStudent.toDomain());
      }
    } on FirebaseException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, LumiUser>> signInUsingGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      final cred = await _auth.signInWithCredential(authCredential);

      final userId = cred.user!.uid;

      return right(await _filterUserType(userId));
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    } on FirebaseException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<void> signOut() async => await _googleSignIn.signOut();

  Future<LumiUser> _filterUserType(String userId) async {
    final userDataDocSnap =
        await _firestore.collection('LumiUserData').doc(userId).get();

    if (userDataDocSnap.exists) {
      final userDataDoc = userDataDocSnap.data()!;

      late final DocumentSnapshot<Map<String, dynamic>> lumiUserDocSnap;

      if (userDataDoc['role'] == null || userDataDoc['role'] == '') {
        return const LumiUser.notRegistered();
      } else if (userDataDoc['role'] == 'creator') {
        lumiUserDocSnap =
            await _firestore.collection('LumiCreators').doc(userId).get();

        return LumiCreatorDto.fromJson(lumiUserDocSnap.data()!).toDomain();
      } else // userDataDoc['role'] == 'student'
      {
        lumiUserDocSnap =
            await _firestore.collection('LumiStudents').doc(userId).get();

        return LumiStudentDto.fromJson(lumiUserDocSnap.data()!).toDomain();
      }
    } else {
      await _firestore.collection('LumiUserData').doc(userId).set(
            UserDataDto(
              uid: userId,
              role: "",
            ).toJson(),
          );

      return const LumiUser.notRegistered();
    }
  }
}
