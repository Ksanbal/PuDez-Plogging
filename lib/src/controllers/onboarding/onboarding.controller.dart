import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/main.dart';

class OnboardingController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
  }

  PageController pageController = PageController();

  RxInt page = 0.obs;

  /// 0: 초록, 1: 회색, 2: 빨강, 3: 랜덤
  RxInt selectedCharacter = 3.obs;

  /// 다음 페이지로 이동
  onPressedNext() {
    page(page.value + 1);
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  /// 이전 페이지로 이동
  onPressedPrev() {
    page(page.value - 1);
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  /// 캐릭터 선택 후 다음 페이지로 이동
  onPressedStart() {
    if (selectedCharacter.value == 3) {
      // 랜덤 선택 시
      character = Random().nextInt(3);
    } else {
      // 선택한 캐릭터 저장 및 Home 페이지로 이동
      character = selectedCharacter.value;
    }

    Get.offNamed('/home');
  }

  /// 캐릭터 선택시
  onPressedCharacter(int index) {
    selectedCharacter(index);
  }
}
