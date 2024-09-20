import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../widgets/gradient_container_design.dart';

class ExitScreen extends StatefulWidget {
  const ExitScreen({super.key});

  @override
  State<ExitScreen> createState() => _ExitScreenState();
}

class _ExitScreenState extends State<ExitScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Exit",
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Image.asset(
                "assets/exit.png",
                width: 300,
                height: 300,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Exit",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Are you sure, you want to exit?",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.lightGreyColor,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientContainerDesign(
                    title: "Exit",
                    width: 120,
                    height: 35,
                    onPressed: () {
                      Get.defaultDialog(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        title: "Confirm Exit",
                        middleText: "",
                        middleTextStyle: const TextStyle(fontSize: 0),
                        titlePadding: const EdgeInsets.only(left: 0, top: 16),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GradientContainerDesign(
                                title: "No",
                                width: 120,
                                height: 35,
                                onPressed: () {
                                  Get.back();
                                  Get.back();
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GradientContainerDesign(
                                title: "Exit",
                                width: 120,
                                height: 35,
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GradientContainerDesign(
                    title: "No",
                    width: 120,
                    height: 35,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
