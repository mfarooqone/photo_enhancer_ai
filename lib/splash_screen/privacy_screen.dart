import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_screen/home_screen.dart';
import '../widgets/gradient_container_design.dart';
import 'exit_screen.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await Get.to(() => const ExitScreen())) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Privacy Policy",
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/privacy.png",
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By using this app, You agree to our ",
                      style: TextStyle(
                        height: 3,
                        color: Colors.grey[500],
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: "\nPrivacy Policy",
                      style: const TextStyle(
                        color: Color(0xFF007556),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Uri url = Uri.parse(
                            "https://muhammadjavidameer.blogspot.com/p/privacy-policy.html",
                          );

                          _launchUrl(url);
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GradientContainerDesign(
                title: "Continue",
                width: 150,
                height: 50,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isPrivacyScreen', true);
                  Get.to(() => const HomeScreen());
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
