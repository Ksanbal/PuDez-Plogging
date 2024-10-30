import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/firebase_options.dart';
import 'package:pudez_plogging/src/common/font.family.dart';
import 'package:pudez_plogging/src/controllers/home/home.controller.dart';
import 'package:pudez_plogging/src/controllers/onboarding/onboarding.controller.dart';
import 'package:pudez_plogging/src/controllers/splash/splash.controller.dart';
import 'package:pudez_plogging/src/views/home/home.view.dart';
import 'package:pudez_plogging/src/views/onboarding/onboarding.view.dart';
import 'package:pudez_plogging/src/views/splash.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: FontFamily.pretendard,
        primaryColor: Colors.white,
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
int? character;
