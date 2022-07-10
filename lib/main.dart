import 'package:flutter/material.dart';
import 'package:flutter_playground/page/home/home_page.dart';
import 'package:flutter_playground/page/login/login_page.dart';
import 'package:flutter_playground/page/profile/profile_page.dart';
import 'package:flutter_playground/page/splash/splash_page.dart';
import 'package:get/get.dart';

import 'util/setup.dart';

void main() async {
  await setup();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      routes: {
        SplashPage.routeName: (ctx) => const SplashPage(),
        HomePage.routeName: (ctx) => const HomePage(),
        LoginPage.routeName: (ctx) => const LoginPage(),
        ProfilePage.routeName: (ctx) => const ProfilePage(),
      },
      initialRoute: SplashPage.routeName,
    );
  }
}
