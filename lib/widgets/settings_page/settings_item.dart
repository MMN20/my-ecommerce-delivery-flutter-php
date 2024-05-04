import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key, required this.name, required this.icon, required this.onTap});
  final String name;
  final Widget icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: icon,
    );
  }
}
