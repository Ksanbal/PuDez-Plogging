import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/common/components/text-button.comp.dart';
import 'package:pudez_plogging/src/common/icon-image.family.dart';
import 'package:pudez_plogging/src/controllers/home/home.controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // 지도
                Container(
                  color: Colors.blue,
                ),
                // 상태
                Padding(
                  padding: const EdgeInsets.fromLTRB(19, 28, 19, 0),
                  child: progressBar(),
                ),
                // 하단 음영
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xffC4C4C4).withAlpha(0),
                          const Color(0xffA0A0A0).withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ),
                // 현재 위치 버튼
                Positioned(
                  bottom: 12,
                  right: 16,
                  child: InkWell(
                    onTap: controller.onPressedMyLocation,
                    child: Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xffE9EBEE),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          IconImageFamily.position,
                          height: 24,
                          width: 24,
                          color: const Color(0xff303538),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 미션 버튼
                Flexible(
                  flex: 2,
                  child: TextButtonComp(
                    onPressed: controller.onPressedMission,
                    text: "",
                    backgroundColor: const Color(0xff303538).withOpacity(0.87),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          IconImageFamily.exclamationCircleMono,
                          height: 20,
                        ),
                        Obx(() {
                          return Text(
                            controller.progress.value == 0
                                ? "미션1 | 집게 찾기 - 위치"
                                : controller.progress.value == 1
                                    ? "미션2 | 봉투 찾기 - 위치"
                                    : "미션3 | 쓰레기 줍기",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          );
                        }),
                        Image.asset(
                          IconImageFamily.arrowRightSmallMono,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                // QR 인증 버튼
                Flexible(
                  flex: 1,
                  child: TextButtonComp(
                    onPressed: controller.onPressedQr,
                    text: "QR 인증",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget progressBar() {
    return Obx(() {
      return Stack(
        alignment: Alignment.center,
        children: [
          // 배경
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xffE9EBEE),
                width: 1,
              ),
            ),
            child: LinearProgressIndicator(
              value: (controller.progress.value + 1) / 4,
              minHeight: 20,
              backgroundColor: const Color(0xffC5C8CE),
              color: const Color(0xff00CD80),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 집게 icon
              controller.progress.value == 0
                  ? Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: const Color(0xff00CD80),
                      ),
                      child: Center(
                        child: Image.asset(
                          IconImageFamily.tongs,
                          height: 24,
                        ),
                      ),
                    )
                  : const Gap(0),
              // 봉투 icon
              controller.progress.value == 1
                  ? Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: const Color(0xff00CD80),
                      ),
                      child: Center(
                        child: Image.asset(
                          IconImageFamily.bags,
                          height: 24,
                        ),
                      ),
                    )
                  : controller.progress.value < 2
                      ? Container(
                          width: 19,
                          height: 19,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xffE9EBEE),
                              width: 1,
                            ),
                            color: const Color(0xffD9D9D9),
                          ),
                        )
                      : const Gap(0),
              // 쓰레기 icon
              controller.progress.value == 2
                  ? Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: const Color(0xff00CD80),
                      ),
                      child: Center(
                        child: Image.asset(
                          IconImageFamily.trash,
                          height: 24,
                        ),
                      ),
                    )
                  : controller.progress.value < 3
                      ? Container(
                          width: 19,
                          height: 19,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xffE9EBEE),
                              width: 1,
                            ),
                            color: const Color(0xffD9D9D9),
                          ),
                        )
                      : const Gap(0),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  color: controller.progress.value == 3
                      ? const Color(0xff00CD80)
                      : const Color(0xffD9D9D9),
                ),
                child: Center(
                  child: Image.asset(
                    IconImageFamily.crown,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
