import 'package:flutter/material.dart';
import 'package:flutter_playground/profile_controller.dart';
import 'package:get/get.dart';

class Profile extends GetView<ProfileController> {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: ListView.separated(
          itemBuilder: (ctx, idx) {
            return Obx(() => TextField(
                  decoration: InputDecoration(
                    label: Text(controller.inputItems[idx].label),
                    border: const OutlineInputBorder(),
                    errorText: _buildErrorTexts(context, idx),
                    suffixIcon: _buildSuffiIcon(context, idx),
                  ),
                  onChanged: (newVal) {
                    controller.onChange(idx, newVal);
                  },
                ));
          },
          separatorBuilder: (ctx, idx) {
            return const SizedBox(
              height: 16,
            );
          },
          itemCount: controller.inputItems.length,
        ),
      ),
    );
  }

  String? _buildErrorTexts(BuildContext context, int idx) {
    if (controller.inputItems[idx].value.isEmpty ||
        controller.inputItems[idx].errors.isEmpty) {
      return null;
    }
    return controller.inputItems[idx].errors.map((e) => "• $e").join("\n");
  }

  Widget? _buildSuffiIcon(BuildContext context, int idx) {
    if (controller.inputItems[idx].value.isEmpty) {
      return null;
    }
    if (controller.inputItems[idx].errors.isEmpty) {
      return const Icon(
        Icons.check_circle_outline_outlined,
        color: Colors.green,
      );
    }
    return const Icon(
      Icons.cancel_outlined,
      color: Colors.red,
    );
  }
}
