import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_textstyle.dart';

class GradientContainerDesign extends StatelessWidget {
  const GradientContainerDesign({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.onPressed,
    this.showTrailingIcon = false,
    this.showLeadingWidget = false,
    this.leading = const SizedBox(),
  });
  final String title;
  final double width;
  final double height;
  final bool showLeadingWidget;
  final bool showTrailingIcon;
  final Widget leading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.pinkColor,
              AppColors.redColor,
              AppColors.orangeColor,
              AppColors.blueColor,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !showLeadingWidget ? const SizedBox() : leading,
                  title.isNotEmpty
                      ? const SizedBox(width: 5)
                      : const SizedBox(),
                  Text(
                    title,
                    style: AppTextStyle.black14,
                  ),
                  !showTrailingIcon
                      ? const SizedBox()
                      : const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
