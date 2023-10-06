import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/core/start_up.dart';
import 'application/auth/auth_bloc.dart';
import 'injection.dart';
import 'init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await initDependencies();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>()
            ..add(
              const AuthEvent.authCheckRequested(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Knowlumi App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StartUpPage(),
      ),
    );
  }
}
