import 'package:flutter/material.dart';
import 'package:flutter_playground/page/login/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  static const routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController(text: controller.email.value),
              onChanged: (newVal) {
                controller.email.value = newVal;
                controller.update();
              },
              decoration: const InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller:
                  TextEditingController(text: controller.password.value),
              onChanged: (newVal) {
                controller.password.value = newVal;
                controller.update();
              },
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Obx(
              () => ElevatedButton(
                onPressed: controller.login.value.maybeWhen(
                  orElse: () => () {
                    controller.loginHandler();
                  },
                  loading: () => null,
                ),
                child: controller.login.value.maybeWhen(
                  orElse: () => const Text('Login'),
                  loading: () => const Text('Loading'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
