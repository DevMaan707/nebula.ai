import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import views
import 'package:nebula_ai/src/features/login/views/login_view.dart';
import 'package:nebula_ai/src/features/home/views/home_view.dart';
import 'package:nebula_ai/src/features/chat/views/chat_view.dart';
import 'package:nebula_ai/src/features/chat/views/chat_creation_view.dart';
import 'package:nebula_ai/src/features/rag/views/rag_view.dart';
import 'package:nebula_ai/src/features/settings/views/settings_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BoltKit.initialize(
    accentColor: Color(0xFF00AEFF),
    primaryColor: Color(0xFFB200FF),
    fontFamily: 'Poppins',
  );
  runApp(Nebula());
}

class Nebula extends StatelessWidget {
  const Nebula({super.key});

  @override
  Widget build(BuildContext context) {
    return BoltKit.builder(
      builder: () => GetMaterialApp(
        title: "Nebula AI",
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.dark,
        initialRoute: '/login',
        getPages: [
          GetPage(name: '/login', page: () => LoginView()),
          GetPage(name: '/home', page: () => HomeView()),
          GetPage(name: '/chat', page: () => ChatView()),
          GetPage(name: '/chat/create', page: () => ChatCreationView()),
          GetPage(name: '/rag', page: () => RagView()),
          GetPage(name: '/settings', page: () => SettingsView()),
        ],
      ),
    );
  }
}
