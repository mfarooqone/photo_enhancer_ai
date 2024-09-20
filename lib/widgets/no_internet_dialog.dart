// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../utils/app_colors.dart';
// import 'gradient_container_design.dart';

// class NointernetDialog extends StatelessWidget {
//   const NointernetDialog({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(
//           Icons.wifi_off_rounded,
//           color: Colors.black,
//           size: 80,
//         ),
//         Text(
//           "No Internet Connection",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: AppColors.blackColor,
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           "Make sure Wi-Fi or mobile data is turned on,\nthen try again",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 12,
//             color: AppColors.blackColor,
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         GradientContainerDesign(
//             title: "Try Again",
//             width: 175,
//             height: 37,
//             onPressed: () {
//               Get.back();
//             }),
//       ],
//     );
//   }
// }
