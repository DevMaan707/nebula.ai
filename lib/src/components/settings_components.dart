import 'package:flutter/material.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';

class ProfileSection extends StatelessWidget {
  final String name;
  final String email;
  final String subscription;
  final Widget avatar;

  const ProfileSection({
    Key? key,
    required this.name,
    required this.email,
    required this.subscription,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.primary.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: avatar,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: AppTextThemes.bodySmall(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    subscription,
                    style: AppTextThemes.caption(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsGroup({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
          child: Text(
            title,
            style: AppTextThemes.bodyMedium(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(14),
          backgroundColor: AppColors.accent.withOpacity(0.7),
          child: Column(
            children: List.generate(
              items.length,
              (index) => Container(
                decoration: BoxDecoration(
                  border: index < items.length - 1
                      ? Border(
                          bottom: BorderSide(
                              color: AppColors.primary.withOpacity(0.1)),
                        )
                      : null,
                ),
                child: items[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const SettingsItem({
    Key? key,
    required this.icon,
    this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        AppTextThemes.bodyMedium(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    subtitle,
                    style: AppTextThemes.caption(color: Colors.grey),
                  ),
                ],
              ),
            ),
            trailing ?? Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
