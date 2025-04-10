import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nebula_ai/src/helpers.dart';

class RagController extends GetxController {
  final RxInt selectedTabIndex = 2.obs;

  final RxList<Map<String, dynamic>> knowledgeBases = <Map<String, dynamic>>[
    {
      'title': 'Product Documentation',
      'description':
          'Technical documentation for our product line including API references, user guides and implementation examples.',
      'documentCount': 24,
      'lastUpdated': '2d ago',
      'tags': ['Technical', 'PDF', 'API'],
    },
    {
      'title': 'Research Papers',
      'description':
          'Collection of research papers on AI, ML models, and natural language processing technologies.',
      'documentCount': 17,
      'lastUpdated': '1w ago',
      'tags': ['Research', 'Academic', 'ML Models'],
    },
    {
      'title': 'Customer FAQs',
      'description':
          'Frequently asked questions and answers about our products and services for customer support.',
      'documentCount': 36,
      'lastUpdated': '3d ago',
      'tags': ['Support', 'FAQ', 'Customer'],
    },
  ].obs;

  final RxList<Map<String, dynamic>> recentQueries = <Map<String, dynamic>>[
    {
      'query':
          'What\'s the recommended setup for AWS Bedrock with RAG systems?',
      'source': 'Product Documentation',
      'time': '2h ago',
    },
    {
      'query':
          'How do I implement a sliding window for long document processing?',
      'source': 'Research Papers',
      'time': 'Yesterday',
    },
    {
      'query':
          'What\'s the difference between embedding methods for technical documents?',
      'source': 'Research Papers',
      'time': '3d ago',
    },
  ].obs;

  final RxList<Map<String, dynamic>> embeddingModels = <Map<String, dynamic>>[
    {
      'name': 'Titan Embeddings',
      'type': 'AWS Bedrock',
      'selected': true,
    },
    {
      'name': 'Cohere Embed',
      'type': 'AWS Bedrock',
      'selected': false,
    },
    {
      'name': 'OpenAI Ada 002',
      'type': 'External API',
      'selected': false,
    },
    {
      'name': 'Custom Model',
      'type': 'Self-hosted',
      'selected': false,
    },
  ].obs;

  void selectEmbeddingModel(int index) {
    for (int i = 0; i < embeddingModels.length; i++) {
      embeddingModels[i]['selected'] = i == index;
    }
    embeddingModels.refresh();

    Toast.show(
      message: '${embeddingModels[index]["name"]} selected as embedding model',
      type: ToastType.success,
    );
  }

  void uploadDocuments() async {
    try {
      final result = await FilePickerUtil().showCustomFilePicker(
        context: Get.context!,
        title: 'Select Documents',
        primaryColor: AppColors.primary,
        allowedExtensions: ['pdf', 'txt', 'docx', 'md'],
      );

      if (result != null) {
        Toast.show(
          message:
              '${result.path.split('/').last} document selected for processing',
          type: ToastType.success,
        );

        // Show processing dialog
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
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(
                    'Processing Documents',
                    style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Extracting text and generating embeddings...',
                    style: AppTextThemes.bodyMedium(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          barrierDismissible: false,
        );

        // Simulate processing
        await Future.delayed(const Duration(seconds: 3));
        Get.back(); // Close dialog

        // Prompt to create or select knowledge base
        _showKnowledgeBaseSelectionDialog(1);
      }
    } catch (e) {
      Toast.show(
        message: 'Failed to select documents: ${e.toString()}',
        type: ToastType.error,
      );
    }
  }

  void _showKnowledgeBaseSelectionDialog(int fileCount) {
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
                'Add to Knowledge Base',
                style: AppTextThemes.heading6(),
              ),
              const SizedBox(height: 20),
              Text(
                'Where would you like to add these $fileCount document(s)?',
                style: AppTextThemes.bodyMedium(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ...knowledgeBases
                      .map((kb) => _buildKnowledgeBaseOption(kb['title']))
                      .toList(),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: AppColors.primary.withOpacity(0.1)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppInput(
                            controller: kbNameController,
                            hint: 'Create new knowledge base',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

  Widget _buildKnowledgeBaseOption(String name) {
    return InkWell(
      onTap: () {
        Get.back();
        Toast.show(
          message: 'Documents added to "\$name"',
          type: ToastType.success,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.primary.withOpacity(0.1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: AppTextThemes.bodyMedium()),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void queryKnowledgeBase(int index) {
    final kb = knowledgeBases[index];

    // Navigate to a query screen or show a query dialog
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
                'Query ${kb['title']}',
                style: AppTextThemes.heading6(),
              ),
              const SizedBox(height: 20),
              AppInput(
                hint: 'Enter your query...',
                type: InputType.multiline,
                maxLines: 3,
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
                      text: 'Search',
                      type: ButtonType.primary,
                      onPressed: () {
                        Get.back();
                        // Simulate response
                        Toast.show(
                          message: 'Query sent to ${kb['title']}',
                          type: ToastType.success,
                        );

                        // Navigate to chat with context of this knowledge base
                        Get.toNamed('/chat', arguments: {
                          'title': 'Query - ${kb['title']}',
                          'knowledgeBase': kb['title'],
                        });
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

  void createNewKnowledgeBase() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Helpers.surfacePrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Create Knowledge Base',
                  style: AppTextThemes.heading6(),
                ),
                const SizedBox(height: 20),
                AppInput(
                  controller: nameController,
                  label: 'Name',
                  hint: 'Enter knowledge base name',
                ),
                const SizedBox(height: 16),
                AppInput(
                  controller: descriptionController,
                  label: 'Description',
                  hint: 'Enter a brief description',
                  type: InputType.multiline,
                  maxLines: 3,
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
                          if (nameController.text.trim().isEmpty) {
                            Toast.show(
                              message: 'Please enter a name',
                              type: ToastType.warning,
                            );
                            return;
                          }

                          knowledgeBases.insert(0, {
                            'title': nameController.text.trim(),
                            'description': descriptionController.text.trim(),
                            'documentCount': 0,
                            'lastUpdated': 'Just now',
                            'tags': ['New'],
                          });

                          Get.back();
                          Toast.show(
                            message: 'Knowledge base created',
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
      ),
    );
  }

  void viewRecentQuery(int index) {
    final query = recentQueries[index];

    Get.toNamed('/chat', arguments: {
      'title': 'Previous Query',
      'initialPrompt': query['query'],
      'knowledgeBase': query['source'],
    });
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
      case 2: // RAG (current screen)
        // Stay on current screen
        break;
      case 3: // Settings
        Get.offAllNamed('/settings');
        break;
    }
  }
}
