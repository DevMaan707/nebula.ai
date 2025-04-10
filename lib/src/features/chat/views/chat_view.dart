import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:nebula_ai/src/controllers/chat_controller.dart';
import 'package:nebula_ai/src/components/app_bar.dart';
import 'package:nebula_ai/src/components/navigation_components.dart';
import 'package:nebula_ai/src/components/input_components.dart';
import 'package:nebula_ai/src/components/message_components.dart';

import '../../../helpers.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.backgroundDark,
      appBar: ChatAppBar(
        modelName: controller.selectedModel.value,
        onBackPressed: () => Get.back(),
        onOptionsPressed: () => {},
      ),
      body: Column(
        children: [
          Obx(() => ModelSelector(
                modelName: controller.selectedModel.value,
                onTap: controller.changeModel,
              )),
          Expanded(
            child: _buildMessageList(),
          ),
          Obx(() => controller.isTyping.value
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, bottom: 8),
                    child: const TypingIndicator(),
                  ),
                )
              : const SizedBox.shrink()),
          ChatInputBox(
            controller: controller.inputController,
            onSend: (text) => controller.sendMessage(),
            onImageAttach: () {},
            onFileAttach: () {},
            onVoiceRecord: () {},
            onCodeSnippet: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return Obx(() => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            final message = controller.messages[index];

            // System message
            if (message.text.startsWith('Chat started with')) {
              return SystemMessage(message: message.text);
            }

            // User or AI message
            if (message.isUserMessage) {
              return MessageBubble(
                message: message.text,
                time: message.time,
                isUserMessage: true,
              );
            } else {
              // AI message
              List<Widget> codeSamples = [];
              if (message.codeSamples != null) {
                codeSamples = message.codeSamples!
                    .map((code) => CodeBlock(code: code))
                    .toList();
              }

              List<Widget>? feedbackOptions;
              if (message.showFeedback) {
                feedbackOptions = [
                  FeedbackButton(
                    icon: Icons.thumb_up,
                    text: 'Helpful',
                    onTap: () => controller.provideFeedback(message.id, true),
                    isActive: message.isHelpful,
                  ),
                  const SizedBox(width: 12),
                  FeedbackButton(
                    icon: Icons.thumb_down,
                    text: 'Not helpful',
                    onTap: () => controller.provideFeedback(message.id, false),
                    isActive: !message.isHelpful && !message.showFeedback,
                  ),
                ];
              }

              return MessageBubble(
                message: message.text,
                time: message.time,
                isUserMessage: false,
                codeSamples: codeSamples,
                feedbackOptions: feedbackOptions,
              );
            }
          },
        ));
  }
}
