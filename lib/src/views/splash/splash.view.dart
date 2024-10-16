import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/controllers/splash/splash.controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
