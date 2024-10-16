import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // 2초 대기
        await Future.delayed(const Duration(seconds: 2));

        // onboarding 페이지로 이동
        Get.offNamed('/onboarding');
      },
    );
  }
}
