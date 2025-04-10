import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';

import '../helpers.dart';

class ChatCreationController extends GetxController {
  final TextEditingController chatNameController = TextEditingController();
  final TextEditingController initialPromptController = TextEditingController();

  final RxInt selectedModelIndex = 0.obs;
  final RxInt selectedKbIndex = 0.obs;
  final RxDouble temperature = 0.7.obs;
  final RxDouble maxTokens = 800.0.obs;
  final RxBool showAdvancedOptions = false.obs;

  final RxList<Map<String, dynamic>> models = <Map<String, dynamic>>[
    {
      'name': 'Llama 3 70B',
      'description': 'Advanced reasoning',
      'icon': Icons.smart_toy,
    },
    {
      'name': 'Llama 3 8B',
      'description': 'Fast responses',
      'icon': Icons.smart_toy,
    },
    {
      'name': 'Mistral 7B',
      'description': 'Efficient model',
      'icon': Icons.smart_toy,
    },
    {
      'name': 'Titan',
      'description': 'AWS proprietary',
      'icon': Icons.cloud,
    },
  ].obs;

  final RxList<Map<String, dynamic>> knowledgeBases = <Map<String, dynamic>>[
    {
      'name': 'General Knowledge',
      'icon': Icons.public,
    },
    {
      'name': 'Product Docs',
      'icon': Icons.description,
    },
    {
      'name': 'Research Papers',
      'icon': Icons.book,
    },
    {
      'name': 'FAQs',
      'icon': Icons.help,
    },
    {
      'name': 'Create New',
      'icon': Icons.add,
    },
  ].obs;

  void selectModel(int index) {
    selectedModelIndex.value = index;
  }

  void selectKnowledgeBase(int index) {
    selectedKbIndex.value = index;

    if (index == knowledgeBases.length - 1) {
      // This is the "Create New" option
      _showCreateKnowledgeBaseDialog();
    }
  }

  void _showCreateKnowledgeBaseDialog() {
    final TextEditingController kbNameController = TextEditingController();

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
                'Create Knowledge Base',
                style: AppTextThemes.heading6(),
              ),
              const SizedBox(height: 20),
              AppInput(
                controller: kbNameController,
                label: 'Knowledge Base Name',
                hint: 'Enter a name for your knowledge base',
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
                      text: 'Create',
                      type: ButtonType.primary,
                      onPressed: () {
                        if (kbNameController.text.trim().isNotEmpty) {
                          _createKnowledgeBase(kbNameController.text.trim());
                          Get.back();
                        } else {
                          Toast.show(
                            message: 'Please enter a knowledge base name',
                            type: ToastType.warning,
                          );
                        }
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

  void _createKnowledgeBase(String name) {
    // Insert the new knowledge base before the "Create New" option
    knowledgeBases.insert(knowledgeBases.length - 1, {
      'name': name,
      'icon': Icons.folder,
    });

    // Select the newly created knowledge base
    selectedKbIndex.value = knowledgeBases.length - 2;

    Toast.show(
      message: 'Knowledge base "\$name" created',
      type: ToastType.success,
    );
  }

  void toggleAdvancedOptions() {
    showAdvancedOptions.value = !showAdvancedOptions.value;
  }

  void createChat() {
    if (chatNameController.text.trim().isEmpty) {
      // Generate a chat name based on the selected model if not provided
      chatNameController.text =
          'Chat with ${models[selectedModelIndex.value]['name']}';
    }

    // Prepare chat data
    final chatData = {
      'name': chatNameController.text.trim(),
      'initialPrompt': initialPromptController.text.trim(),
      'model': models[selectedModelIndex.value],
      'knowledgeBase': knowledgeBases[selectedKbIndex.value],
      'temperature': temperature.value,
      'maxTokens': maxTokens.value.toInt(),
    };

    // Navigate to the chat screen with the created chat
    Get.offNamed('/chat', arguments: chatData);

    Toast.show(
      message: 'Chat created: ${chatData['name']}',
      type: ToastType.success,
    );
  }

  @override
  void onClose() {
    chatNameController.dispose();
    initialPromptController.dispose();
    super.onClose();
  }
}
