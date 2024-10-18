import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/common/image.family.dart';
import 'package:pudez_plogging/src/controllers/splash/splash.controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImageFamily.splash,
          scale: 4,
        ),
      ),
    );
  }
}
