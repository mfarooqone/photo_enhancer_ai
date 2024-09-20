import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_enhancer_ai/splash_screen/privacy_screen.dart';

import '../home_screen/home_screen.dart';
import '../widgets/gradient_container_design.dart';
import 'exit_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isPrivacyScreen = false;

  Future<bool> _onWillPop() async {
    return (await Get.to(() => const ExitScreen())) ?? false;
  }

  @override
  void initState() {
    super.initState();
  }

  bool sdkInit = false;
  bool adLoaded = false;
  String sdkVersion = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BounceInDown(
                    from: 400,
                    delay: const Duration(milliseconds: 1000),
                    child: Container(
                      width: 162,
                      height: 162,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        "assets/app_icon.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Photo Enhancer AI",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: GradientContainerDesign(
                  title: "Get Started",
                  width: 150,
                  height: 50,
                  onPressed: () {
                    !isPrivacyScreen
                        ? Get.to(() => const PrivacyScreen())
                        : Get.off(() => const HomeScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
