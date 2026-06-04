import 'package:flutter/material.dart';
import 'package:session_3/core/assets.dart';
import 'package:session_3/core/text_styles.dart';

class MenuOptionWidget extends StatelessWidget {
  const MenuOptionWidget({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 20,
          top: 16,
          bottom: 16,
        ),
        child: Row(
          children: [
            Text(title, style: TextStyles.bodyM),
            Spacer(),
            Image.asset(Assets.rightArrowIcon),
          ],
        ),
      ),
    );
  }
}
