import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/controllers/home/home.controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}