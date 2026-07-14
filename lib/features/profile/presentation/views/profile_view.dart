import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:session_3/app_colors.dart';
import 'package:session_3/core/assets.dart';
import 'package:session_3/core/text_styles.dart';
import 'package:session_3/features/profile/domain/use_cases/update_profile_picture_use_case.dart';

import 'package:session_3/features/profile/presentation/widgets/menu_option_widget.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings', style: TextStyles.header4),
          centerTitle: true,
        ),
        body: Column(
          children: const [
            _HeaderSection(),
            _VerticalMenuSection(),
            Spacer(),
            _BottomOptionsSection(),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(Assets.avatarIcon, width: 80, height: 80),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      UpdateProfilePictureUseCase().call();
                    },
                    child: Icon(Icons.edit, size: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('Lucas Scott', style: TextStyles.header3),
          SizedBox(height: 4),
          Text('@lucasscott13', style: TextStyles.bodyS),
        ],
      ),
    );
  }
}

class _VerticalMenuSection extends StatelessWidget {
  const _VerticalMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: _menuOptions
            .map(
              (option) => Column(
                children: [
                  MenuOptionWidget(title: option.title, onTap: option.onTap),
                  Container(height: 0.5, color: Colors.grey),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class MenuOption {
  final String title;
  final VoidCallback onTap;

  MenuOption({required this.title, required this.onTap});
}

final List<MenuOption> _menuOptions = [
  MenuOption(title: 'Saved Messages', onTap: () {}),
  MenuOption(title: 'Recent Calls', onTap: () {}),
  MenuOption(title: 'Devices', onTap: () {}),
  MenuOption(title: 'Notifications', onTap: () {}),
  MenuOption(title: 'Appearance', onTap: () {}),
  MenuOption(title: 'Language', onTap: () {}),
  MenuOption(title: 'Privacy & Security', onTap: () {}),
  MenuOption(title: 'Storage', onTap: () {}),
];

class _BottomOptionsSection extends StatelessWidget {
  const _BottomOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Bottom Options Section');
  }
}
