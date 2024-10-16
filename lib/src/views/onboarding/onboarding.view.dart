import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/controllers/onboarding/onboarding.controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Onboarding"),
      ),
    );
  }
}
