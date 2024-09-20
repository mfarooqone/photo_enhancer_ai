import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_fonts_family.dart';

class TextEditorController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isEdit = true.obs;
  RxBool isItalic = false.obs;
  late TextStyle textStyle;
  late TextAlign textAlign;
  double textSize = 24.0;
  String fontFamily = AppFontFamily.emizen;
  FontWeight fontWeight = FontWeight.w500;
  FontStyle fontStyle = FontStyle.normal;
  Color textColor = Colors.white;
  Color textBackgroundColor = Colors.transparent;
  RxInt selectedBottomIndex = 0.obs;
  Widget currentWidget = const SizedBox();
  int selectedFontIndex = 0;

  List<String> fontsList = [];
  List<Color> colorsList = [];
  List<Icon> iconsList = [];

  @override
  void onInit() {
    textAlign = TextAlign.center;
    textStyle = TextStyle(
      decorationStyle: TextDecorationStyle.wavy,
      fontSize: textSize,
      color: textColor,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      backgroundColor: textBackgroundColor,
    );
    fontsList = [
      AppFontFamily.emizen,
      AppFontFamily.magicalhistory,
      AppFontFamily.rookworst,
      AppFontFamily.theoriesregular,
      AppFontFamily.viavallens,
      AppFontFamily.wholecarwhite,
      AppFontFamily.ironbridge,
      AppFontFamily.bufelos,
      AppFontFamily.gerona,
      AppFontFamily.snap,
      AppFontFamily.spantaran,
      AppFontFamily.ariblk,
      AppFontFamily.brushking,
      AppFontFamily.greatday,
      AppFontFamily.stencul,
      AppFontFamily.roboto,
      AppFontFamily.gothic,
    ];
    colorsList = [
      Colors.transparent,
      Colors.white,
      Colors.black,
      Color(int.parse('0xffEA2027')),
      Color(int.parse('0xff006266')),
      Color(int.parse('0xff1B1464')),
      Color(int.parse('0xff5758BB')),
      Color(int.parse('0xff6F1E51')),
      Color(int.parse('0xffB53471')),
      Color(int.parse('0xffEE5A24')),
      Color(int.parse('0xff009432')),
      Color(int.parse('0xff0652DD')),
      Color(int.parse('0xff9980FA')),
      Color(int.parse('0xff833471')),
      Color(int.parse('0xff112CBC4')),
      Color(int.parse('0xffFDA7DF')),
      Color(int.parse('0xffED4C67')),
      Color(int.parse('0xffF79F1F')),
      Color(int.parse('0xffA3CB38')),
      Color(int.parse('0xff1289A7')),
      Color(int.parse('0xffD980FA'))
    ];
    iconsList = [
      const Icon(
        Icons.keyboard,
        size: 35,
      ),
      const Icon(
        Icons.font_download_rounded,
        size: 35,
      ),
      const Icon(
        Icons.format_italic_rounded,
        size: 35,
      ),
      const Icon(
        Icons.format_color_text_rounded,
        size: 35,
      ),
      const Icon(
        Icons.format_color_fill_rounded,
        size: 35,
      ),
    ];
    super.onInit();
  }

  void onTapBottom(int index) {
    isLoading.value = true;
    selectedBottomIndex.value = index;
    tappedIcon(index);
  }

  void tappedIcon(int index) {
    isLoading.value = true;
    if (index == 0) {
      isEdit.value = true;
      currentWidget = const SizedBox();
    } else if (index == 1) {
      /* -------------------------------------------------------------------------- */
      /*                               fontStyleWidget                              */
      /* -------------------------------------------------------------------------- */
      currentWidget = fontStyleWidget();
    } else if (index == 2) {
      currentWidget = textStyleWidget();
    } else if (index == 3) {
      currentWidget = textColorWidget();
    } else if (index == 4) {
      currentWidget = textBgColorWidget();
    }
    isLoading.value = false;
  }

  Widget fontStyleWidget() {
    return Obx(() {
      return isLoading.value
          ? const CircularProgressIndicator()
          : Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: fontsList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        isLoading.value = true;
                        selectedFontIndex = index;
                        fontFamily = fontsList[index];
                        textStyle = TextStyle(
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSize: textSize,
                          color: textColor,
                          fontFamily: fontFamily,
                          fontWeight: fontWeight,
                          fontStyle: fontStyle,
                          backgroundColor: textBackgroundColor,
                        );
                        isLoading.value = false;
                      },
                      child: Container(
                        // width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          color: index == selectedFontIndex
                              ? Colors.grey[300]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Font Style",
                              style: TextStyle(
                                fontFamily: fontsList[index],
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
    });
  }

  Widget textColorWidget() {
    return Obx(() {
      return isLoading.value
          ? const CircularProgressIndicator()
          : Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: colorsList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        isLoading.value = true;
                        textColor = colorsList[index];
                        textStyle = TextStyle(
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSize: textSize,
                          color: textColor,
                          fontFamily: fontFamily,
                          fontWeight: fontWeight,
                          fontStyle: fontStyle,
                          backgroundColor: textBackgroundColor,
                        );
                        isLoading.value = false;
                      },
                      child: index == 0
                          ? const SizedBox()
                          : Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: colorsList[index],
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: index == 0
                                  ? const Icon(
                                      Icons.colorize_rounded,
                                      color: Colors.black,
                                    )
                                  : const SizedBox(),
                            ),
                    ),
                  );
                },
              ),
            );
    });
  }

  Widget textBgColorWidget() {
    return Obx(() {
      return isLoading.value
          ? const CircularProgressIndicator()
          : Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: colorsList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        isLoading.value = true;
                        textBackgroundColor = colorsList[index];
                        update();

                        textStyle = TextStyle(
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSize: textSize,
                          color: textColor,
                          fontFamily: fontFamily,
                          fontWeight: fontWeight,
                          fontStyle: fontStyle,
                          backgroundColor: textBackgroundColor,
                        );
                        isLoading.value = false;
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: colorsList[index],
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: index == 0
                            ? const Icon(
                                Icons.colorize_rounded,
                                color: Colors.black,
                              )
                            : const SizedBox(),
                      ),
                    ),
                  );
                },
              ),
            );
    });
  }

  Widget textStyleWidget() {
    return Obx(() {
      return isLoading.value
          ? const CircularProgressIndicator()
          : Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    // color: Colors.red,
                    child: InkWell(
                      onTap: () {
                        isLoading.value = true;
                        log("regular");
                        fontWeight = FontWeight.normal;
                        textStyle = TextStyle(
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSize: textSize,
                          color: textColor,
                          fontFamily: fontFamily,
                          fontWeight: fontWeight,
                          fontStyle: fontStyle,
                          backgroundColor: textBackgroundColor,
                        );
                        isLoading.value = false;
                        update();
                      },
                      child: const Center(
                        child: Text(
                          "R",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    // color: Colors.red,
                    child: IconButton(
                      iconSize: 24,
                      icon: const Icon(
                        Icons.format_bold_rounded,
                      ),
                      onPressed: () {
                        isLoading.value = true;
                        fontWeight = FontWeight.bold;
                        log("bold");
                        textStyle = TextStyle(
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSize: textSize,
                          color: textColor,
                          fontFamily: fontFamily,
                          fontWeight: fontWeight,
                          fontStyle: fontStyle,
                          backgroundColor: textBackgroundColor,
                        );
                        isLoading.value = false;
                        update();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: IconButton(
                      iconSize: 24,
                      onPressed: () {
                        isLoading.value = true;

                        if (isItalic.value) {
                          fontStyle = FontStyle.italic;
                          isItalic.value = false;
                          textStyle = TextStyle(
                            decorationStyle: TextDecorationStyle.wavy,
                            fontSize: textSize,
                            color: textColor,
                            fontFamily: fontFamily,
                            fontWeight: fontWeight,
                            fontStyle: FontStyle.italic,
                            backgroundColor: textBackgroundColor,
                          );
                          log(isItalic.toString());
                        } else if (!isItalic.value) {
                          fontStyle = FontStyle.normal;
                          isItalic.value = true;
                          log(isItalic.toString());
                          textStyle = TextStyle(
                            decorationStyle: TextDecorationStyle.wavy,
                            fontSize: textSize,
                            color: textColor,
                            fontFamily: fontFamily,
                            fontWeight: fontWeight,
                            fontStyle: FontStyle.normal,
                            backgroundColor: textBackgroundColor,
                          );
                        }

                        isLoading.value = false;
                        update();
                      },
                      icon: const Icon(
                        Icons.format_italic_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
