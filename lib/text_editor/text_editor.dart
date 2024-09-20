import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:photo_enhancer_ai/home_screen/home_screen.dart';
import 'package:photo_enhancer_ai/save_screen/save_screen.dart';
import 'package:photo_enhancer_ai/utils/app_colors.dart';
import 'package:photo_enhancer_ai/utils/app_textstyle.dart';
import 'package:photo_enhancer_ai/widgets/gradient_container_design.dart';
import 'package:screenshot/screenshot.dart';

import 'text_editor_controller.dart';

class TextEditorScreen extends StatefulWidget {
  const TextEditorScreen(
      {super.key,
      required this.buttonText,
      this.userImage,
      required this.index});
  final String buttonText;
  final File? userImage;
  final int index;

  @override
  State<TextEditorScreen> createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  TextEditorController tEController = Get.put(TextEditorController());
  ScreenshotController screenshotController = ScreenshotController();

  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    // textEditingController.text = "";

    tEController.textAlign = TextAlign.left;

    super.initState();
  }

  Offset offset = const Offset(150, 300);
  // double scale = 0.0;
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
  Future<bool> _onWillPop() async {
    return (await Get.defaultDialog(
          title: "Discard Changes",
          content: dialogWidget(),
        )) ??
        false;
  }

  Widget dialogWidget() {
    return Column(
      children: [
        Text(
          "If you exit before saving it, you'll lose it.",
          style: AppTextStyle.black14,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GradientContainerDesign(
              height: 39,
              width: 120,
              title: "Save Image",
              onPressed: () {
                setState(() {
                  var wwww = zoomRotateWidget(notifier);
                  screenshotController
                      .captureFromWidget(wwww)
                      .then((capturedImage) {
                    Get.to(
                      () => SaveScreen(
                        buttonText: widget.buttonText,
                        userImage: widget.userImage,
                        index: widget.index,
                        bytes: capturedImage,
                      ),
                    );
                  });
                });
              },
              showTrailingIcon: false,
              showLeadingWidget: true,
              leading: Icon(
                Icons.save_alt_rounded,
                size: 15,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GradientContainerDesign(
              height: 39,
              width: 120,
              title: "Exit",
              onPressed: () {
                Get.offAll(() => const HomeScreen());
              },
              showTrailingIcon: false,
              showLeadingWidget: true,
              leading: Icon(
                Icons.exit_to_app_outlined,
                size: 15,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: tEController.isLoading.value
                ? const SpinKitSpinningLines(color: Colors.black)
                : Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (tEController.isEdit.value)
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(widget.userImage!),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: BlurryContainer(
                              blur: 20,
                              width: double.infinity,
                              height: double.infinity,
                              borderRadius: BorderRadius.circular(0),
                              child: const SizedBox(),
                            ),
                          ),
                        ),

                      /* -------------------------------------------------------------------------- */
                      /*                                  editText                                  */
                      /* -------------------------------------------------------------------------- */
                      if (tEController.isEdit.value) editText(),
                      if (!tEController.isEdit.value)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 52,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await Get.defaultDialog(
                                          title: "Discard Changes",
                                          content: dialogWidget(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 24,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          tEController.isLoading.value = true;
                                          var wwww = zoomRotateWidget(notifier);
                                          screenshotController
                                              .captureFromWidget(wwww)
                                              .then((capturedImage) {
                                            Get.to(
                                              () => SaveScreen(
                                                buttonText: widget.buttonText,
                                                userImage: widget.userImage,
                                                index: widget.index,
                                                bytes: capturedImage,
                                              ),
                                            );
                                            tEController.isLoading.value =
                                                false;
                                          });
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        size: 24,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (!tEController.isEdit.value)
                                    /* -------------------------------------------------------------------------- */
                                    /*                              zoomRotateWidget                              */
                                    /* -------------------------------------------------------------------------- */

                                    zoomRotateWidget(notifier),
                                ],
                              ),
                              const Spacer(),
                              /* -------------------------------------------------------------------------- */
                              /*                                currentWidget                                */
                              /* -------------------------------------------------------------------------- */
                              Container(
                                color: Colors.transparent,
                                height: 50,
                                child: tEController.currentWidget,
                              ),
                              Container(
                                color: Colors.white,
                                height: 50,
                                width: double.infinity,
                                child: Center(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tEController.iconsList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            tEController.onTapBottom(index);
                                            tEController.update();
                                          },
                                          child: Container(
                                            width: 70,
                                            height: 50,
                                            color: index ==
                                                    tEController
                                                        .selectedBottomIndex
                                                        .value
                                                ? Colors.grey[300]
                                                : Colors.white,
                                            child:
                                                tEController.iconsList[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      );
    });
  }

  MatrixGestureDetector zoomRotateWidget(ValueNotifier<Matrix4> notifier) {
    return MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
      },
      child: SizedBox(
        width: double.infinity,
        height: 480,
        child: Stack(
          children: [
            Center(
              child: Image.file(
                widget.userImage!,
                width: double.infinity,
                height: 480,
                fit: BoxFit.fitWidth,
              ),
            ),
            /* -------------------------------------------------------------------------- */
            /*                                original Text                               */
            /* -------------------------------------------------------------------------- */
            if (!tEController.isEdit.value)
              Center(
                child: AnimatedBuilder(
                  animation: notifier,
                  builder: (ctx, child) {
                    return Transform(
                      transform: notifier.value,
                      child: Center(
                        child: Transform.scale(
                          scale: 1,
                          origin: const Offset(0.0, 0.0),
                          child: GestureDetector(
                            onTap: () {
                              tEController.isEdit.value = true;
                            },
                            child: Text(
                              textEditingController.text,
                              textAlign: tEController.textAlign,
                              style: tEController.textStyle,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget editText() {
    return Container(
      color: Colors.black.withOpacity(0.1),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    tEController.isEdit.value = false;
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 24,
                  ),
                ),
                TextAlignOption(
                  icon: Icons.format_align_left,
                  isActive: tEController.textAlign == TextAlign.left,
                  onPressed: () {
                    setState(() => tEController.textAlign = TextAlign.left);
                  },
                ),
                TextAlignOption(
                  icon: Icons.format_align_center,
                  isActive: tEController.textAlign == TextAlign.center,
                  onPressed: () {
                    setState(() => tEController.textAlign = TextAlign.center);
                  },
                ),
                TextAlignOption(
                  icon: Icons.format_align_right,
                  isActive: tEController.textAlign == TextAlign.right,
                  onPressed: () {
                    setState(() => tEController.textAlign = TextAlign.right);
                  },
                ),
                IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      tEController.isEdit.value = false;
                    });
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.multiline,
            maxLength: null,
            maxLines: null,
            textAlign: tEController.textAlign,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Sample Text",
              hintStyle: tEController.textStyle,
            ),
            style: tEController.textStyle,
            autofocus: true,
            onSubmitted: (val) {
              setState(() {
                tEController.isEdit.value = false;
                textEditingController.text = val;
              });
            },
          ),
        ],
      ),
    );
  }
}

class TextAlignOption extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final bool isActive;

  // ignore: use_key_in_widget_constructors
  const TextAlignOption({
    required this.icon,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 24,
      icon: Icon(icon),
      color: isActive
          ? Theme.of(context).iconTheme.color
          : Theme.of(context).disabledColor,
      onPressed: onPressed,
    );
  }
}
