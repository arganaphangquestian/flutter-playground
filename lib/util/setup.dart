import 'package:flutter/material.dart';
import 'package:flutter_playground/data/datasource/local_datasource.dart';
import 'package:flutter_playground/data/datasource/remote_datasource.dart';
import 'package:flutter_playground/data/repository/repository_impl.dart';
import 'package:flutter_playground/domain/usecases/login_usecase.dart';
import 'package:flutter_playground/domain/usecases/me_usecase.dart';
import 'package:flutter_playground/main_controller.dart';
import 'package:flutter_playground/page/home/home_controller.dart';
import 'package:flutter_playground/page/login/login_controller.dart';
import 'package:flutter_playground/page/profile/profile_controller.dart';
import 'package:flutter_playground/page/splash/splash_controller.dart';
import 'package:flutter_playground/util/client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'persistance.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put<AppPref>(AppPref());
  // Data Source
  Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl(client()));
  Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
  // Repository
  Get.lazyPut<RepositoryImpl>(
    () => RepositoryImpl(
      Get.find<RemoteDataSource>(),
      Get.find<LocalDataSource>(),
    ),
  );
  // Use Cases
  Get.lazyPut<LoginUseCase>(
    () => LoginUseCase(Get.find<RepositoryImpl>()),
  );
  Get.lazyPut<MeUseCase>(
    () => MeUseCase(Get.find<RepositoryImpl>()),
  );
  // Get.lazyPut<RegisterUseCase>(() => RegisterUseCase());
  // Controllers
  Get.put<MainController>(MainController());
  Get.lazyPut<HomeController>(() => HomeController());
  Get.lazyPut<LoginController>(
    () => LoginController(Get.find<LoginUseCase>()),
  );
  Get.lazyPut<ProfileController>(
    () => ProfileController(Get.find<MeUseCase>()),
  );
  Get.lazyPut<SplashController>(() => SplashController());
}
