import 'package:flutter/material.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:get/get.dart';

class NebulaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const NebulaAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: onBackPressed ?? () => Get.back(),
            )
          : null,
      title: title != null
          ? Text(title!, style: AppTextThemes.heading6())
          : Image.asset('assets/images/logo.png', height: 30),
      centerTitle: title != null,
      actions: actions ??
          [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary,
                child: Text('JD',
                    style: AppTextThemes.bodyMedium(color: Colors.white)),
              ),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String modelName;
  final bool isModelActive;
  final VoidCallback? onBackPressed;
  final VoidCallback? onOptionsPressed;

  const ChatAppBar({
    Key? key,
    required this.modelName,
    this.isModelActive = true,
    this.onBackPressed,
    this.onOptionsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: onBackPressed ?? () => Get.back(),
      ),
      title: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(modelName,
                  style: AppTextThemes.bodySmall(fontWeight: FontWeight.w500)),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isModelActive ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isModelActive ? 'Active' : 'Inactive',
                    style: AppTextThemes.caption(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
          ),
          onPressed: onOptionsPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
