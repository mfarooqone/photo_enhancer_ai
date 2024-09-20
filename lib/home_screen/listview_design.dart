import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imagelib;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:photo_enhancer_ai/edit_screen/edit_screen.dart';
import 'package:photofilters/filters/preset_filters.dart';

import '../photo_filter/photo_filter_screen.dart';
import '../text_editor/text_editor.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../widgets/choose_photo_bottom_sheet.dart';

class ListViewDesign extends StatefulWidget {
  const ListViewDesign({super.key});

  @override
  State<ListViewDesign> createState() => _ListViewDesignState();
}

class _ListViewDesignState extends State<ListViewDesign> {
  String? fileName;
  File? imageFile;

  File? _userImage;
  List<String> imagesList = [
    AppImagesPath.enhanceCarousel,
    AppImagesPath.filterCarousel,
    AppImagesPath.textCarousel,
    AppImagesPath.hdrCarousel,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imagesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: GestureDetector(
            onTap: () {
              _showBottomSheet(
                context,
                index,
              );
            },
            child: SizedBox(
              width: 180,
              height: 180,
              child: Image.asset(
                imagesList[index],
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(
    BuildContext context,
    int index,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctz) {
        return ChoosePhotoBottomSheet(
          onChooseFromLibraryPressed: () {
            Get.back();
            _chooseImage(
              context,
              imageSource: ImageSource.gallery,
              index: index,
            );
          },
          onTakePhotoPressed: () {
            Get.back();
            _chooseImage(
              context,
              imageSource: ImageSource.camera,
              index: index,
            );
          },
        );
      },
    );
  }

  Future<void> _chooseImage(
    BuildContext context, {
    required ImageSource imageSource,
    required int index,
  }) async {
    final image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 2048.0,
      maxHeight: 2048.0,
    );
    if (image != null) {
      final imageFile = File(image.path);
      setState(() {
        _userImage = imageFile;
        tapped(index, _userImage!);
      });
    }
  }

  void tapped(int index, File? userImage) async {
    if (_userImage != null) {
      log("this is the index ======= $index");
      /* -------------------------------------------------------------------------- */
      /*                                index ==== 0                                */
      /* -------------------------------------------------------------------------- */
      if (index == 0) {
        Get.to(
          () => EditScreen(
            buttonText: "Enhance",
            userImage: userImage,
            index: index,
          ),
        );
      }
      /* -------------------------------------------------------------------------- */
      /*                                index ==== 1                                */
      /* -------------------------------------------------------------------------- */
      else if (index == 1) {
        imageFile = File(userImage!.path);
        fileName = basename(imageFile!.path);
        List<int> bytes = await imageFile!.readAsBytes();
        var image = imagelib.decodeImage(bytes);
        image = imagelib.copyResize(image!, width: 600);

        // LoadAdClass().interstetialAd(
        //   SessionController.admob_interstetial_home_screen,
        //   SessionController.applovin_interstetial_home_screen,
        //   SessionController.fb_interstetial_home_screen,
        // );

        Get.to(
          () => PhotoFilterSelector(
            title: Text(
              "Select Filter",
              style: TextStyle(color: AppColors.blackColor),
            ),
            image: image!,
            filters: presetFiltersList,
            filename: fileName!,
            loader: const SpinKitSpinningLines(color: Colors.black),
            fit: BoxFit.contain,
            userImage: userImage,
          ),
        );
      }
      /* -------------------------------------------------------------------------- */
      /*                                index ==== 2                                */
      /* -------------------------------------------------------------------------- */
      else if (index == 2) {
        Get.to(
          () => TextEditorScreen(
            buttonText: "Text Style",
            userImage: userImage,
            index: index,
          ),
        );
      }
      /* -------------------------------------------------------------------------- */
      /*                                index ==== 3                                */
      /* -------------------------------------------------------------------------- */
      else if (index == 3) {
        Get.to(
          () =>
              EditScreen(buttonText: "HDR", userImage: userImage, index: index),
        );
      }
    }
  }
}
