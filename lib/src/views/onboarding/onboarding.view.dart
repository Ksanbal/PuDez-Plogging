import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/common/components/outline-text-button.comp.dart';
import 'package:pudez_plogging/src/common/components/text-button.comp.dart';
import 'package:pudez_plogging/src/common/font.family.dart';
import 'package:pudez_plogging/src/common/image.family.dart';
import 'package:pudez_plogging/src/controllers/onboarding/onboarding.controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: PageView(
          controller: controller.pageController,
          children: [
            // 안녕하세요!
            page1(),
            // 참여방법
            page2(),
            // 캐릭터 선택
            page3(),
          ],
        ),
      ),
    );
  }

  Widget pageIndicator() {
    return SmoothPageIndicator(
      controller: controller.pageController,
      count: 3,
      effect: const WormEffect(
        radius: 8,
        dotWidth: 8,
        dotHeight: 8,
        dotColor: Color(0xffDDDDDD),
        activeDotColor: Color(0xff303538),
      ),
    );
  }

  Widget page1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(10),
                const Text(
                  "안녕하세요!",
                  style: TextStyle(
                    fontFamily: FontFamily.notosans,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff303538),
                  ),
                ),
                const Gap(8),
                const Text(
                  "우리는 <걷고 싶은 거리>를 만들기 위해 모인\n퍼디즈예요! 지금있는 마포 거리를 변화시키기 위해\n당신의 용기있는 참여가 꼭 필요해요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff303538),
                  ),
                ),
                const Gap(24),
                Flexible(
                  child: Image.asset(
                    ImageFamily.onboarding_1,
                  ),
                ),
                const Gap(24),
                // PageView Navigator
                pageIndicator(),
                const Gap(10),
              ],
            ),
          ),
          // Route Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButtonComp(
              onPressed: controller.onPressedNext,
              text: "다음",
            ),
          ),
        ],
      ),
    );
  }

  Widget page2() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(10),
                const Text(
                  "참여방법",
                  style: TextStyle(
                    fontFamily: FontFamily.notosans,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff303538),
                  ),
                ),
                const Gap(8),
                const Text(
                  "플로깅에 필요한 물품 위치를 지도에 알려드릴게요.\n물품을 찾고, 쓰레기를 줍고 완료하면\n선물도 준비했으니 끝까지 완주해 주세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff303538),
                  ),
                ),
                const Gap(24),
                Flexible(child: Image.asset(ImageFamily.onboarding_2)),
                const Gap(24),
                // PageView Navigator
                pageIndicator(),
                const Gap(10),
              ],
            ),
          ),
        ),
        // Route Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: OutlineTextButtonComp(
                  onPressed: controller.onPressedPrev,
                  text: "이전",
                ),
              ),
              const Gap(9),
              Expanded(
                child: TextButtonComp(
                  onPressed: controller.onPressedNext,
                  text: "다음",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget page3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(10),
                const Text(
                  "캐릭터 선택",
                  style: TextStyle(
                    fontFamily: FontFamily.notosans,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff303538),
                  ),
                ),
                const Gap(8),
                const Text(
                  "함께 플로깅에 참여할\n친구를 선택해 주세요.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff303538),
                  ),
                ),
                const Gap(24),
                Flexible(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Obx(() {
                          final isSelected = controller.selectedCharacter.value == index;

                          return InkWell(
                            onTap: () => controller.onPressedCharacter(index),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xff00CD80).withOpacity(0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: isSelected
                                    ? Border.all(
                                        color: const Color(0xff00CD80),
                                        width: 2,
                                      )
                                    : Border.all(
                                        color: const Color(0xffE9EBEE),
                                        width: 1,
                                      ),
                              ),
                              child: Center(
                                child: index < 3
                                    ? Image.asset(
                                        ImageFamily.characterList[index],
                                      )
                                    : Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff303538),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "랜덤",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
                const Gap(24),
                // PageView Navigator
                pageIndicator(),
                const Gap(10),
              ],
            ),
          ),
          // Route Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlineTextButtonComp(
                    onPressed: controller.onPressedPrev,
                    text: "이전",
                  ),
                ),
                const Gap(9),
                Expanded(
                  child: TextButtonComp(
                    onPressed: controller.onPressedStart,
                    text: "시작",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
