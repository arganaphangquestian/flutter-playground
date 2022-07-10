import 'package:flutter/material.dart';
import 'package:flutter_playground/domain/entity/user.dart';
import 'package:flutter_playground/page/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  static const routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.load();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.load();
        },
        child: Stack(
          children: [
            ListView(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Center(
                child: Obx(() => _build(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _build(BuildContext context) {
    return controller.user.value.maybeWhen(
      orElse: () => const SizedBox(),
      success: (user) => _buildSuccess(context, user),
      loading: () => _buildLoading(context),
      error: (message) => _buildError(context, message),
    );
  }

  Widget _buildSuccess(BuildContext context, User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(user.name),
        Text(user.email),
      ],
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const CircularProgressIndicator();
  }

  Widget _buildError(BuildContext context, String message) {
    return Text(message);
  }
}
