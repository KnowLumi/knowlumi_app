import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/course/lumi_curriculum.dart';
import '../pages/add_curriculum_page.dart';

Future<void> showSectionCreationDialog({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Add Section"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Section Title",
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Section Description",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.router.pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            int order = ref.watch(activeCurriculumProvider)!.sections!.length;

            ref.read(activeCurriculumProvider.notifier).update(
              (state) {
                var sec = state!.sections!;

                sec = [
                  ...sec,
                  Section(
                    templateId: order,
                    title: "Section 2",
                    subtitle: "New Sub",
                    lessons: [],
                  ),
                ];

                return state.copyWith(
                  sections: sec,
                );
              },
            );

            context.router.pop();
          },
          child: Text("Add"),
        ),
      ],
    ),
  );
}
