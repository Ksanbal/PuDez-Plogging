import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/common/components/outline-text-button.comp.dart';
import 'package:pudez_plogging/src/common/components/text-button.comp.dart';
import 'package:pudez_plogging/src/common/icon-image.family.dart';
import 'package:pudez_plogging/src/common/image.family.dart';

class CompleteBottomSheet extends StatelessWidget {
  const CompleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 46, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 타이틀
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      ImageFamily.confetti,
                      height: 43,
                    ),
                    const Text(
                      "미션 클리어!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff303538),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                // 설명
                const Text(
                  "미션을 모두 성공했어요!\n더 나은 세상을 만들어줘서 감사해요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff636C73),
                  ),
                ),
                const Gap(8),
                // 완료 이미지
                Flexible(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset(ImageFamily.ending),
                  ),
                ),
                const Gap(24),
                // 공유 버튼
                OutlineTextButtonComp(
                  onPressed: () {},
                  text: "공유하기",
                ),
                const Gap(8),
                // 완료 버튼
                TextButtonComp(
                  onPressed: () {
                    Get.back();
                    Get.offNamed('/');
                  },
                  text: "완료",
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: () {
                Get.back();
                Get.offNamed('/');
              },
              icon: Image.asset(
                IconImageFamily.closed,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
