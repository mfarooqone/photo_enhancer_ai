import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as imagelib;
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';

import '../save_screen/save_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    required this.buttonText,
    this.userImage,
    required this.index,
  });
  final String buttonText;
  final File? userImage;
  final int index;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  bool showProgressAnimation = false;
  List<int>? _bytes;

  convertImage() async {
    var image = imagelib.decodeImage(await widget.userImage!.readAsBytes());
    image = imagelib.copyResize(image!, width: 600);
    applyFilter(<String, dynamic>{
      "filter": LoFiFilter(),
      "image": image,
      "filename": "thisismyfilename.jpg",
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
        value: 0.0, duration: const Duration(seconds: 5), vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      convertImage();
      Future.delayed(const Duration(seconds: 3), () {
        if (widget.index == 3) {
          Get.to(
            () => SaveScreen(
              buttonText: widget.buttonText,
              userImage: widget.userImage,
              index: widget.index,
              bytes: _bytes,
            ),
          );
        } else {
          Get.to(
            () => SaveScreen(
              buttonText: widget.buttonText,
              userImage: widget.userImage,
              index: widget.index,
              bytes: _bytes,
            ),
          );
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitSpinningLines(color: Colors.black),
      ),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "${widget.buttonText} Photo",
      //     style: AppTextStyle.black16,
      //   ),
      //   leading: InkWell(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Icon(
      //       Icons.close,
      //       color: AppColors.blackColor,
      //       size: 30,
      //     ),
      //   ),
      // ),
      // body: Stack(
      //   children: [
      //     Column(
      //       children: [
      //         Padding(
      //           padding:
      //               const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
      //           child: Center(
      //             child: Container(
      //               height: 494.0,
      //               decoration: BoxDecoration(
      //                 color: Colors.red,
      //                 gradient: LinearGradient(
      //                   begin: Alignment.topRight,
      //                   end: Alignment.bottomLeft,
      //                   colors: [
      //                     AppColors.pinkColor,
      //                     AppColors.redColor,
      //                     AppColors.blueColor,
      //                   ],
      //                 ),
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //               child: Padding(
      //                 padding: const EdgeInsets.all(2.0),
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(8),
      //                     color: Colors.white,
      //                   ),
      //                   clipBehavior: Clip.hardEdge,
      //                   child: PhotoView.customChild(
      //                     backgroundDecoration: const BoxDecoration(
      //                       color: Colors.transparent,
      //                     ),
      //                     initialScale: 1.0,
      //                     child: Image.file(
      //                       widget.userImage!,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         /* -------------------------------------------------------------------------- */
      //         /*                           GradientContainerDesign                          */
      //         /* -------------------------------------------------------------------------- */
      //         const Spacer(),
      //         GradientContainerDesign(
      //           height: 48,
      //           width: 126,
      //           title: widget.buttonText,
      //           onPressed: () {
      //             _showProcessAnimation();
      //           },
      //           showTrailingIcon: true,
      //         ),
      //         const SizedBox(
      //           height: 16,
      //         ),
      //       ],
      //     ),
      //     !showProgressAnimation
      //         ? const SizedBox()
      //         : Align(
      //             child: Container(
      //               width: double.infinity,
      //               height: double.infinity,
      //               color: AppColors.blackColor.withOpacity(0.6),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   SizedBox(
      //                     height: 222.0,
      //                     width: 222.0,
      //                     child: Lottie.asset(
      //                       AppImagesPath.processAnimation,
      //                       fit: BoxFit.fill,
      //                       controller: animationController,
      //                       animate: true,
      //                       repeat: false,
      //                       onLoaded: (composition) {
      //                         animationController.forward().whenComplete(() {
      //                           animationController.dispose();
      //                           animationController = AnimationController(
      //                               value: 0.0,
      //                               duration: const Duration(seconds: 5),
      //                               vsync: this);
      //                           setState(() {
      //                             showProgressAnimation = false;
      //                           });
      //                           if (widget.index == 3) {
      //                             Get.to(
      //                               () => SaveScreen(
      //                                 buttonText: widget.buttonText,
      //                                 userImage: widget.userImage,
      //                                 index: widget.index,
      //                                 bytes: _bytes,
      //                               ),
      //                             );
      //                           } else {
      //                             Get.to(
      //                               () => SaveScreen(
      //                                 buttonText: widget.buttonText,
      //                                 userImage: widget.userImage,
      //                                 index: widget.index,
      //                                 bytes: _bytes,
      //                               ),
      //                             );
      //                           }
      //                         });
      //                       },
      //                     ),
      //                   ),
      //                   Text(
      //                     "Process takes\nabout 10 seconds,\nplease wait",
      //                     style: AppTextStyle.whiteSemiBold30,
      //                     textAlign: TextAlign.center,
      //                   ),
      //                   const SizedBox(
      //                     height: 30,
      //                   ),
      //                   InkWell(
      //                     onTap: () {
      //                       setState(() {
      //                         showProgressAnimation = false;
      //                         animationController.dispose();
      //                         animationController = AnimationController(
      //                             value: 0.0,
      //                             duration: const Duration(seconds: 5),
      //                             vsync: this);
      //                       });
      //                     },
      //                     child: Container(
      //                         width: 51,
      //                         height: 51,
      //                         decoration: BoxDecoration(
      //                           color: AppColors.whiteColor.withOpacity(0.5),
      //                           shape: BoxShape.circle,
      //                         ),
      //                         child: Icon(
      //                           Icons.close,
      //                           color: AppColors.whiteColor,
      //                           size: 35,
      //                         )),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //   ],
      // ),
    );
  }

  FutureOr<List<int>> applyFilter(Map<String, dynamic> params) {
    Filter? filter = params["filter"];
    imagelib.Image image = params["image"];
    String filename = params["filename"];

    _bytes = image.getBytes();
    if (filter != null) {
      filter.apply(_bytes as dynamic, image.width, image.height);
    }
    imagelib.Image image1 =
        imagelib.Image.fromBytes(image.width, image.height, _bytes!);
    setState(() {
      _bytes = imagelib.encodeNamedImage(image1, filename)!;
    });
    // log(_bytes.toString());
    return _bytes!;
  }

  // _showProcessAnimation() {
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {});
  //   setState(() {
  //     showProgressAnimation = true;
  //   });
  // }
}
