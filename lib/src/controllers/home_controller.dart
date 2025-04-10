import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';

class HomeController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  final RxList<Map<String, dynamic>> models = <Map<String, dynamic>>[
    {
      'name': 'Llama 3 70B',
      'description': 'Advanced reasoning & complexity',
      'stats': ['Fast', '70B'],
      'badge': 'Pro',
      'isSelected': true,
    },
    {
      'name': 'Llama 3 8B',
      'description': 'Balanced performance',
      'stats': ['Efficient', '8B'],
      'badge': null,
      'isSelected': false,
    },
    {
      'name': 'Mistral 7B',
      'description': 'High efficiency model',
      'stats': ['Fast', '7B'],
      'badge': null,
      'isSelected': false,
    },
    {
      'name': 'Titan',
      'description': 'AWS proprietary model',
      'stats': ['Secure', 'Safe'],
      'badge': 'New',
      'isSelected': false,
    },
  ].obs;

  final RxList<Map<String, dynamic>> recentChats = <Map<String, dynamic>>[
    {
      'title': 'Product Development',
      'preview': 'Let\'s explore some innovative features for the new...',
      'time': '2h ago',
      'icon': Icons.smart_toy,
      'iconBackground': Color(0xFF8C5CFF),
    },
    {
      'title': 'Code Review Assistant',
      'preview': 'The error in your React component might be...',
      'time': 'Yesterday',
      'icon': Icons.smart_toy,
      'iconBackground': Color(0xFF3F8CFF),
    },
    {
      'title': 'Market Research Analysis',
      'preview': 'Based on the data you provided, the market trends show...',
      'time': '2d ago',
      'icon': Icons.smart_toy,
      'iconBackground': Color(0xFF00B3FF),
    },
  ].obs;

  void selectModel(int index) {
    for (int i = 0; i < models.length; i++) {
      models[i]['isSelected'] = i == index;
    }
    models.refresh();

    final selectedModel = models[index];

    Toast.show(
      message: '${selectedModel['name']} selected',
      type: ToastType.success,
    );
  }

  void openChat(int index) {
    // Navigate to chat screen with the selected chat data
    Get.toNamed('/chat', arguments: recentChats[index]);
  }

  void createNewChat() {
    // Navigate to chat creation screen
    Get.toNamed('/chat/create');
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;

    switch (index) {
      case 0: // Home
        break;
      case 1:
        Get.toNamed('/chat');
        break;
      case 2: // RAG
        Get.toNamed('/rag');
        break;
      case 3: // Settings
        Get.toNamed('/settings');
        break;
    }
  }
}
