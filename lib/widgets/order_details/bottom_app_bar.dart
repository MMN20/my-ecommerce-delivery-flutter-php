import 'package:flutter/material.dart';
import 'package:my_ecommerce_delivery/core/constants/colors.dart';

class OrderDetailsBottomAppBar extends StatelessWidget {
  const OrderDetailsBottomAppBar(
      {super.key, required this.onTap, required this.text});
  final void Function() onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          color: AppColors.thirdColor10,
          height: 50,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
        ));
  }
}
