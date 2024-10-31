import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/common/components/text-button.comp.dart';
import 'package:pudez_plogging/src/common/image.family.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    super.key,
    required this.progress,
  });

  final int progress;

  static List<String> titles = [
    "<집게&봉투> 위치",
    "쓰레기 줍기",
  ];
  static List<String> descriptions = [
    "해당 위치까지 가면 획득할 수 있어요!",
    "봉투를 다 채웠다면,\n가까운 부스(A 또는 B)로 와주세요!",
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.all(28),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              titles[progress],
              style: const TextStyle(
                color: Color(0xff303538),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(8),
            Text(
              descriptions[progress],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff636C73),
                fontSize: 14,
              ),
            ),
            const Gap(8),
            if (progress == 0)
              Flexible(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      ImageFamily.item,
                    ),
                  ),
                ),
              ),
            if (progress == 1) ...[
              Flexible(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        ImageFamily.spot0,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff303538),
                        ),
                        child: const Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Flexible(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        ImageFamily.spot1,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff303538),
                        ),
                        child: const Center(
                          child: Text(
                            "B",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Gap(24),
            TextButtonComp(
              onPressed: Get.back,
              text: "확인",
            ),
          ],
        ),
      ),
    );
  }
}
