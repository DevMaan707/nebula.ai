import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:nebula_ai/src/controllers/auth_controller.dart';

import '../../../helpers.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.backgroundDark,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    AppCard(
                      padding: const EdgeInsets.all(30),
                      borderRadius: BorderRadius.circular(16),
                      backgroundColor: Helpers.surfacePrimary.withOpacity(0.7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [AppColors.primary, AppColors.accent],
                            ).createShader(bounds),
                            child: Text(
                              'Welcome Back',
                              style: AppTextThemes.heading5(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          AppInput(
                            label: 'Email',
                            hint: 'Enter your email',
                            prefixIcon: Icons.email,
                            type: InputType.email,
                            onChanged: (value) =>
                                controller.email.value = value,
                          ),
                          const SizedBox(height: 16),
                          AppInput(
                            label: 'Password',
                            hint: 'Enter your password',
                            prefixIcon: Icons.lock,
                            type: InputType.password,
                            onChanged: (value) =>
                                controller.password.value = value,
                          ),
                          const SizedBox(height: 24),
                          Obx(() => Button(
                                text: controller.isLoading.value
                                    ? 'Signing In...'
                                    : 'Sign In',
                                type: ButtonType.primary,
                                isLoading: controller.isLoading.value,
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.login,
                                width: double.infinity,
                              )),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: controller.forgotPassword,
                            child: Text(
                              'Forgot password?',
                              style:
                                  AppTextThemes.bodySmall(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
