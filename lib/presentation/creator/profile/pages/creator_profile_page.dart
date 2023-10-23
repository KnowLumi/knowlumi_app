import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../domain/auth/lumi_user.dart';

@RoutePage()
class CreatorProfilePage extends StatelessWidget {
  final LumiCreator creator;

  const CreatorProfilePage({required this.creator, super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Creator Profile"),
      ),
    );
  }
}
