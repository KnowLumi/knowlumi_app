import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../domain/auth/lumi_user.dart';

@RoutePage()
class StudentMainPage extends StatelessWidget {
  final LumiStudent student;

  const StudentMainPage({required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
