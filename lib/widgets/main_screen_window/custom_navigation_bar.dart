import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_ecommerce_delivery/core/constants/colors.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: AppColors.thirdColor10.withOpacity(0.3),
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: children),
          ),
        ),
      ),
    );
  }
}
