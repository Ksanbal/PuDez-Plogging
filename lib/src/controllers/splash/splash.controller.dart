import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // 2초 대기
        await Future.delayed(const Duration(seconds: 2));

        FlutterNativeSplash.remove();

        // onboarding 페이지로 이동
        Get.offNamed('/onboarding');
      },
    );
  }
}
