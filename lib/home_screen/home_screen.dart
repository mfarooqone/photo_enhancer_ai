import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_enhancer_ai/drawer_design/drawer_design.dart';
import 'package:photo_enhancer_ai/utils/app_colors.dart';

import '../splash_screen/exit_screen.dart';
import 'listview_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await Get.to(() => const ExitScreen())) ?? false;
  }

  bool isBotomSheet = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isBotomSheet) {
              isBotomSheet = false;
            }
          });
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: const DrawerDesign(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Photo Enhancer AI",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                iconSize: 35,
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu_rounded,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
          body: const Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 13,
                    ),
                    ListViewDesign(),
                    SizedBox(
                      height: 84,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showActions() {
    return Container(
      color: Colors.transparent,
      height: 80,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            height: 50,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.orange,
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF7E03FB),
                    Color(0xFFDC01F9),
                    Color(0xFFF20080),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isBotomSheet = !isBotomSheet;
                  });
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
