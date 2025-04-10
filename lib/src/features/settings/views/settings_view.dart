import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:nebula_ai/src/controllers/settings_controller.dart';
import 'package:nebula_ai/src/components/navigation_components.dart';

import '../../../components/app_bar.dart';
import '../../../components/model_selection_components.dart';
import '../../../components/settings_components.dart';
import '../../../helpers.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);

  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.backgroundDark,
      body: Stack(
        children: [
          // Background glow effect
          Positioned(
            top: Get.height * 0.2,
            left: Get.width * 0.5,
            child: Transform.translate(
              offset: const Offset(-150, -150),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.15),
                      AppColors.accent.withOpacity(0.05),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 0.7],
                  ),
                ),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection(),
                  _buildAccountSettings(),
                  _buildAISettings(),
                  _buildAppearanceSettings(),
                  _buildNotificationSettings(),
                  _buildVersionInfo(),
                  _buildSignOutButton(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => NebulaBottomNavBar(
            currentIndex: controller.selectedTabIndex.value,
            onTabChanged: controller.changeTab,
          )),
    );
  }

  Widget _buildProfileSection() {
    return Obx(() => ProfileSection(
          name: controller.userName.value,
          email: controller.userEmail.value,
          subscription: controller.subscription.value,
          avatar: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Text(
              controller.userName.value.substring(0, 2),
              style: AppTextThemes.heading6(color: Colors.white),
            ),
          ),
        ));
  }

  Widget _buildAccountSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SettingsGroup(
        title: 'Account',
        items: [
          SettingsItem(
            icon: Icons.person,
            title: 'Profile Information',
            subtitle: 'Change your account details',
            onTap: controller.updateProfile,
          ),
          SettingsItem(
            icon: Icons.lock,
            title: 'Security',
            subtitle: 'Manage password and 2FA',
            onTap: controller.navigateToSecurity,
          ),
          SettingsItem(
            icon: Icons.credit_card,
            title: 'Subscription',
            subtitle: controller.subscription.value, // Direct string value
            onTap: controller.navigateToSubscription,
          ),
        ],
      ),
    );
  }

  Widget _buildAISettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SettingsGroup(
        title: 'AI Settings',
        items: [
          SettingsItem(
            icon: Icons.memory,
            title: 'Default Model',
            subtitle: controller.defaultModel.value, // Direct string value
            onTap: controller.navigateToDefaultModel,
          ),
          SettingsItem(
            icon: Icons.tune,
            title: 'Model Parameters',
            subtitle: 'Temperature, tokens, etc.',
            onTap: controller.navigateToModelParameters,
          ),
          SettingsItem(
            icon: Icons.key,
            title: 'API Keys',
            subtitle: 'Manage AWS credentials',
            onTap: controller.navigateToApiKeys,
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SettingsGroup(
        title: 'Appearance',
        items: [
          SettingsItem(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Always enabled',
            trailing: Obx(() => AnimatedToggle(
                  isActive: controller.darkModeEnabled.value,
                  onToggle: (bool value) => controller.toggleDarkMode(),
                )),
            onTap: controller.toggleDarkMode,
          ),
          SettingsItem(
            icon: Icons.text_fields,
            title: 'Font Size',
            subtitle: 'Adjust text display',
            onTap: controller.navigateToFontSize,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SettingsGroup(
        title: 'Notifications',
        items: [
          SettingsItem(
            icon: Icons.notifications,
            title: 'Push Notifications',
            subtitle: 'For chat responses',
            trailing: Obx(() => AnimatedToggle(
                  isActive: controller.pushNotificationsEnabled.value,
                  onToggle: (bool value) =>
                      controller.togglePushNotifications(),
                )),
            onTap: controller.togglePushNotifications,
          ),
          SettingsItem(
            icon: Icons.email,
            title: 'Email Notifications',
            subtitle: 'Weekly summaries',
            trailing: Obx(() => AnimatedToggle(
                  isActive: controller.emailNotificationsEnabled.value,
                  onToggle: (bool value) =>
                      controller.toggleEmailNotifications(),
                )),
            onTap: controller.toggleEmailNotifications,
          ),
        ],
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        'App Version: 1.2.3 • AWS Bedrock Integration: 2.1.0',
        style: AppTextThemes.caption(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Button(
        text: 'Sign Out',
        type: ButtonType.secondary,
        icon: Icons.logout,
        onPressed: controller.signOut,
        width: double.infinity,
      ),
    );
  }
}
