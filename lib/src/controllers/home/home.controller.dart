import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/main.dart';
import 'package:pudez_plogging/src/views/home/complete.bottomsheet.dart';
import 'package:pudez_plogging/src/views/home/info.dialog.dart';
import 'package:pudez_plogging/src/views/home/qr.dialog.dart';

class HomeController extends GetxController {
  @override
  onReady() {
    super.onReady();

    if (character == null) Get.offNamed('/');

    Future.delayed(const Duration(seconds: 1), onPressedMission);

    ever(progress, (value) {
      Future.delayed(
        const Duration(milliseconds: 500),
        value < 3 ? onPressedMission : onComplete,
      );
    });
  }

  /// 진행도
  ///
  /// 0 : 집게 찾기, 1: 봉투 찾기, 2: 플로깅 진행, 3: 완료
  RxInt progress = 0.obs;

  /// 미션 버튼 클릭 이벤트 -> dialog 노출
  onPressedMission() {
    Get.dialog(
      InfoDialog(
        progress: progress.value,
      ),
    );
  }

  /// QR 인증 버튼 이벤트 -> dialog 노출
  onPressedQr() async {
    final value = await Get.dialog(
      const QrDialog(),
    );

    if (value != null) {
      final completeCode = "pudez:${progress.value}";

      if (value == completeCode) {
        progress(progress.value + 1);
      } else {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => Get.snackbar(
            "QR 인증 실패",
            "QR 코드가 일치하지 않습니다.",
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            backgroundColor: Colors.white,
          ),
        );
      }
    }
  }

  /// 현재 사용자 위치로 이동하는 함수
  onPressedMyLocation() {}

  // 미션 완료 dialog 노출 함수
  onComplete() {
    Get.bottomSheet(
      const CompleteBottomSheet(),
      isScrollControlled: true,
      isDismissible: false,
    );
  }
}
