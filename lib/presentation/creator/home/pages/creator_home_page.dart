import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../domain/auth/lumi_user.dart';

@RoutePage()
class CreatorHomePage extends StatelessWidget {
  final LumiCreator creator;

  const CreatorHomePage({required this.creator, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
