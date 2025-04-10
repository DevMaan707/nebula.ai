import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:nebula_ai/src/controllers/chat_creation_controller.dart';
import 'package:nebula_ai/src/components/app_bar.dart';
import 'package:nebula_ai/src/components/card_components.dart';
import 'package:nebula_ai/src/components/knowledge_base_components.dart';
import 'package:nebula_ai/src/components/model_selection_components.dart';

import '../../../helpers.dart';

class ChatCreationView extends StatelessWidget {
  ChatCreationView({super.key});

  final ChatCreationController controller = Get.put(ChatCreationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.backgroundDark,
      appBar: NebulaAppBar(
        title: 'New Chat',
        showBackButton: true,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextThemes.bodyMedium(color: Colors.grey),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChatDetailsSection(),
            const SizedBox(height: 24),
            _buildModelSelectionSection(),
            const SizedBox(height: 24),
            _buildKnowledgeBaseSection(),
            const SizedBox(height: 24),
            _buildParametersSection(),
            const SizedBox(height: 24),
            Obx(() => AdvancedToggle(
                  isActive: controller.showAdvancedOptions.value,
                  onToggled: (value) => controller.toggleAdvancedOptions(),
                )),
            const SizedBox(height: 24),
            Button(
              text: 'Create Chat',
              type: ButtonType.primary,
              onPressed: controller.createChat,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildChatDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.edit, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Chat Details',
              style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppInput(
          controller: controller.chatNameController,
          label: 'Chat Name (Optional)',
          hint: 'E.g., Project Brainstorming',
        ),
        const SizedBox(height: 16),
        AppInput(
          controller: controller.initialPromptController,
          label: 'Initial Prompt (Optional)',
          hint:
              'Start with a specific prompt or leave empty to start from scratch',
          type: InputType.multiline,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildModelSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Select Model',
              style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.models.length,
              itemBuilder: (context, index) {
                final isSelected = controller.selectedModelIndex.value == index;
                return ModelCard(
                  name: controller.models[index]['name'],
                  description: controller.models[index]['description'],
                  isSelected: isSelected,
                  onTap: () => controller.selectModel(index),
                );
              },
            )),
      ],
    );
  }

  Widget _buildKnowledgeBaseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dataset, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Knowledge Base',
              style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                controller.knowledgeBases.length,
                (index) => KnowledgeBaseOption(
                  text: controller.knowledgeBases[index]['name'],
                  icon: controller.knowledgeBases[index]['icon'],
                  isSelected: controller.selectedKbIndex.value == index,
                  onTap: () => controller.selectKnowledgeBase(index),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildParametersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Model Parameters',
              style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Obx(() => ParameterSlider(
                    name: 'Temperature',
                    value: controller.temperature.value,
                    min: 0,
                    max: 1,
                    step: 0.1,
                    onChanged: (value) => controller.temperature.value = value,
                  )),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Obx(() => ParameterSlider(
                    name: 'Max Tokens',
                    value: controller.maxTokens.value,
                    min: 100,
                    max: 2000,
                    step: 100,
                    onChanged: (value) => controller.maxTokens.value = value,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
