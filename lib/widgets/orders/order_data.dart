import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderData extends StatelessWidget {
  const OrderData({
    super.key,
    required this.name,
    required this.value,
    this.valueStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  });
  final String name;
  final String value;

  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$name:",
          style: const TextStyle(fontSize: 15),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: valueStyle,
          ),
        ),
      ],
    );
  }
}
