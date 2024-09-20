import 'package:flutter/material.dart';
import 'package:photo_enhancer_ai/utils/app_colors.dart';
import 'package:photo_enhancer_ai/utils/app_textstyle.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerDesign extends StatefulWidget {
  const DrawerDesign({super.key});

  @override
  State<DrawerDesign> createState() => _DrawerDesignState();
}

class _DrawerDesignState extends State<DrawerDesign> {
  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 307,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/drawer.png",
                ),
                const SizedBox(
                  height: 20,
                ),

                GradientText(
                  "Photo Enhancer AI",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                  ),
                  colors: [
                    AppColors.pinkColor,
                    AppColors.redColor,
                    AppColors.blueColor,
                    AppColors.orangeColor,
                  ],
                ),
                // const Divider(),

                /* -------------------------------------------------------------------------- */
                /*                                    Share                                   */
                /* -------------------------------------------------------------------------- */

                // ListTile(
                //   onTap: () {
                //     Share.share('Hello', subject: 'check out this app');
                //   },
                //   leading: Icon(
                //     Icons.share,
                //     size: 20,
                //     color: AppColors.blackColor,
                //   ),
                //   title: Text(
                //     "Share",
                //     style: AppTextStyle.black16,
                //   ),
                // ),
                /* -------------------------------------------------------------------------- */
                /*                               Privacy Policy                               */
                /* -------------------------------------------------------------------------- */
                const Divider(),
                ListTile(
                  onTap: () {
                    Uri url = Uri.parse(
                      "https://muhammadjavidameer.blogspot.com/p/privacy-policy.html",
                    );

                    _launchUrl(url);
                  },
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                  title: Text(
                    "Privacy Policy",
                    style: AppTextStyle.black16,
                  ),
                ),
                const Divider(),
                /* -------------------------------------------------------------------------- */
                /*                            terms and conditions                            */
                /* -------------------------------------------------------------------------- */
                // const Divider(),
                // ListTile(
                //   onTap: () {
                //     Uri url = Uri.parse(
                //         "https://docs.google.com/document/d/1SvleJc1JzBNrj_Ji28DmEYOybbX2VN6if0Z-Y_McIZ8/edit");

                //     _launchUrl(url);
                //   },
                //   leading: Icon(
                //     Icons.privacy_tip_outlined,
                //     size: 20,
                //     color: AppColors.blackColor,
                //   ),
                //   title: Text(
                //     "Terms & Conditions",
                //     style: AppTextStyle.black16,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
