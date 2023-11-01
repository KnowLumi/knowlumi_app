import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final httpClientProvider = Provider((_) => Client());

final googleSignInProvider = Provider((_) => GoogleSignIn());

final fireAuthProvider = Provider((_) => FirebaseAuth.instance);

final firestoreProvider = Provider((_) => FirebaseFirestore.instance);
