import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:nebula_ai/src/helpers.dart';

class SettingsController extends GetxController {
  final RxInt selectedTabIndex = 3.obs; // Settings tab is selected by default

  // User profile data
  final RxString userName = 'John Doe'.obs;
  final RxString userEmail = 'john.doe@example.com'.obs;
  final RxString subscription = 'Pro Plan'.obs;

  // Settings toggles
  final RxBool darkModeEnabled = true.obs;
  final RxBool pushNotificationsEnabled = true.obs;
  final RxBool emailNotificationsEnabled = false.obs;

  // Default model settings
  final RxString defaultModel = 'Llama 3 70B'.obs;

  void updateProfile() {
    final TextEditingController nameController =
        TextEditingController(text: userName.value);
    final TextEditingController emailController =
        TextEditingController(text: userEmail.value);

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Helpers.surfacePrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profile',
                style: AppTextThemes.heading6(),
              ),
              const SizedBox(height: 20),
              AppInput(
                controller: nameController,
                label: 'Full Name',
                hint: 'Enter your full name',
              ),
              const SizedBox(height: 16),
              AppInput(
                controller: emailController,
                label: 'Email',
                hint: 'Enter your email address',
                type: InputType.email,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Cancel',
                      type: ButtonType.secondary,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Button(
                      text: 'Save',
                      type: ButtonType.primary,
                      onPressed: () {
                        userName.value = nameController.text.trim();
                        userEmail.value = emailController.text.trim();
                        Get.back();
                        Toast.show(
                          message: 'Profile updated',
                          type: ToastType.success,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToSecurity() {
    // Navigate to security settings screen
    Toast.show(
      message: 'Security settings would be shown here',
      type: ToastType.info,
    );
  }

  void navigateToSubscription() {
    // Navigate to subscription settings screen
    Toast.show(
      message: 'Subscription settings would be shown here',
      type: ToastType.info,
    );
  }

  void navigateToDefaultModel() {
    final models = ['Llama 3 70B', 'Llama 3 8B', 'Mistral 7B', 'Titan'];

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Helpers.surfacePrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Default Model',
                style: AppTextThemes.heading6(),
              ),
              const SizedBox(height: 20),
              ...models.map((model) => _buildModelOption(model)).toList(),
              const SizedBox(height: 20),
              Button(
                text: 'Cancel',
                type: ButtonType.secondary,
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModelOption(String model) {
    return InkWell(
      onTap: () {
        defaultModel.value = model;
        Get.back();
        Toast.show(
          message: 'Default model set to \$model',
          type: ToastType.success,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.primary.withOpacity(0.1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(model, style: AppTextThemes.bodyMedium()),
            if (defaultModel.value == model)
              Icon(Icons.check, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  void navigateToModelParameters() {
    // Navigate to model parameters settings
    Toast.show(
      message: 'Model parameters settings would be shown here',
      type: ToastType.info,
    );
  }

  void navigateToApiKeys() {
    // Navigate to API keys settings
    Toast.show(
      message: 'API keys settings would be shown here',
      type: ToastType.info,
    );
  }

  void toggleDarkMode() {
    darkModeEnabled.value = !darkModeEnabled.value;
    // Implement actual theme change logic here
    Toast.show(
      message:
          darkModeEnabled.value ? 'Dark mode enabled' : 'Dark mode disabled',
      type: ToastType.success,
    );
  }

  void navigateToFontSize() {
    // Navigate to font size settings
    Toast.show(
      message: 'Font size settings would be shown here',
      type: ToastType.info,
    );
  }

  void togglePushNotifications() {
    pushNotificationsEnabled.value = !pushNotificationsEnabled.value;
    Toast.show(
      message: pushNotificationsEnabled.value
          ? 'Push notifications enabled'
          : 'Push notifications disabled',
      type: ToastType.success,
    );
  }

  void toggleEmailNotifications() {
    emailNotificationsEnabled.value = !emailNotificationsEnabled.value;
    Toast.show(
      message: emailNotificationsEnabled.value
          ? 'Email notifications enabled'
          : 'Email notifications disabled',
      type: ToastType.success,
    );
  }

  void signOut() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Helpers.surfacePrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sign Out',
                style: AppTextThemes.heading6(),
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to sign out?',
                style: AppTextThemes.bodyMedium(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Cancel',
                      type: ButtonType.secondary,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Button(
                      text: 'Sign Out',
                      type: ButtonType.secondary,
                      onPressed: () {
                        Get.back();
                        Get.offAllNamed('/login');
                        Toast.show(
                          message: 'Successfully signed out',
                          type: ToastType.success,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;

    switch (index) {
      case 0: // Home
        Get.offAllNamed('/home');
        break;
      case 1: // Chats
        Get.offAllNamed('/chats');
        break;
      case 2: // RAG
        Get.offAllNamed('/rag');
        break;
      case 3: // Settings (current screen)
        // Stay on current screen
        break;
    }
  }
}
