import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/auth/auth_provider.dart';
import '../../../../domain/auth/lumi_user.dart';

@RoutePage()
class CreatorProfilePage extends ConsumerWidget {
  final LumiCreator creator;

  const CreatorProfilePage({required this.creator, super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Creator Profile"),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ref.read(authenticationProvider.notifier).signOut();
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
