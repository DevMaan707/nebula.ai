import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Toast.show(
        message: 'Please enter email and password',
        type: ToastType.error,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to home screen on success
      Get.offAllNamed('/home');
    } catch (e) {
      Toast.show(
        message: 'Login failed: ${e.toString()}',
        type: ToastType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void forgotPassword() {
    // Implement forgot password functionality
    Toast.show(
      message: 'Reset password link sent to your email',
      type: ToastType.info,
    );
  }

  void signup() {
    // Navigate to signup page
    Get.toNamed('/signup');
  }
}
