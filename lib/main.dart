import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/common/font.family.dart';
import 'package:pudez_plogging/src/controllers/home/home.controller.dart';
import 'package:pudez_plogging/src/controllers/onboarding/onboarding.controller.dart';
import 'package:pudez_plogging/src/controllers/splash/splash.controller.dart';
import 'package:pudez_plogging/src/views/home/home.view.dart';
import 'package:pudez_plogging/src/views/onboarding/onboarding.view.dart';
import 'package:pudez_plogging/src/views/splash/splash.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: FontFamily.pretendard,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashView(),
          binding: BindingsBuilder(() {
            Get.put(SplashController());
          }),
        ),
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingView(),
          binding: BindingsBuilder(() {
            Get.put(OnboardingController());
          }),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeView(),
          binding: BindingsBuilder(() {
            Get.put(HomeController());
          }),
        ),
      ],
    );
  }
}

/// Global variables

/// 선택한 캐릭터
///
/// 0: 초록, 1: 회색, 2: 빨강, 3: 랜덤
int character = 3;
