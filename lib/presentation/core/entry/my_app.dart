import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../../application/creator/course/crt_course_bloc.dart';
import '../../../application/upload/upload_bloc.dart';
import '../../../injection.dart';
import '../routes/app_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

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
        BlocProvider(
          create: (context) => getIt<CrtCourseBloc>()
            ..add(
              const CrtCourseEvent.fetchAllCourses(),
            ),
        ),
        BlocProvider(
          create: (context) => getIt<UploadBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Knowlumi App',
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
