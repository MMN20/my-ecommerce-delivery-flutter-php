// this widget is for PageView to keep its desired child alive and not rebuild it for every time when show it on screen

import 'package:flutter/material.dart';

class KeepChildAlive extends StatefulWidget {
  const KeepChildAlive({super.key, required this.child});
  final Widget child;
  @override
  State<KeepChildAlive> createState() => _KeepChildAliveState();
}

class _KeepChildAliveState extends State<KeepChildAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
