import 'package:flutter/material.dart';

class BottomOptionWidget extends StatelessWidget {
  const BottomOptionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isActive,
  });

  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(title),
          Image.asset(icon, color: isActive ? Colors.blue : Colors.grey),
        ],
      ),
    );
  }
}
