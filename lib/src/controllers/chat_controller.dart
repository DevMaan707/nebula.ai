import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers.dart';

class MessageModel {
  final String id;
  final String text;
  final String time;
  final bool isUserMessage;
  final List<String>? codeSamples;
  bool showFeedback;
  bool isHelpful;

  MessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.isUserMessage,
    this.codeSamples,
    this.showFeedback = false,
    this.isHelpful = false,
  });
}

class ChatController extends GetxController {
  final TextEditingController inputController = TextEditingController();
  final RxString selectedModel = "Llama 3 70B".obs;
  final RxBool isTyping = false.obs;
  final RxList<MessageModel> messages = <MessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add initial system message
    messages.add(
      MessageModel(
        id: DateTime.now().toString(),
        text: 'Chat started with \${selectedModel.value} - Today',
        time: '',
        isUserMessage: false,
      ),
    );

    // Add sample conversation for demonstration
    _addSampleConversation();
  }

  void _addSampleConversation() {
    // Example user message
    messages.add(
      MessageModel(
        id: DateTime.now().toString(),
        text:
            'Can you explain the key differences between Llama 3 8B and Llama 3 70B models?',
        time: '3:45 PM',
        isUserMessage: true,
      ),
    );

    // Example AI response with code sample
    messages.add(
      MessageModel(
        id: DateTime.now().toString(),
        text:
            '''The key differences between Llama 3 8B and Llama 3 70B models revolve around their size, capabilities, and performance trade-offs:

1. Parameter Count: As the names suggest, Llama 3 8B has 8 billion parameters, while Llama 3 70B has 70 billion parameters.
2. Reasoning Capabilities: The 70B model demonstrates significantly stronger reasoning, problem-solving, and nuanced understanding of complex queries.
3. Resource Requirements: The 8B model requires less computational resources to run, making it more suitable for deployment on devices with limited capabilities or when optimizing for cost.
4. Context Window: Both models support an 8K context window, but the 70B model generally makes better use of the available context.
5. Speed: The 8B model typically generates responses faster due to its smaller size.

Choose the 8B model when you need efficiency and reasonable performance, and the 70B model when you require deeper reasoning and better handling of complex tasks.''',
        time: '3:46 PM',
        isUserMessage: false,
        codeSamples: [
          '''| Feature           | Llama 3 8B                | Llama 3 70B               |
|-------------------|---------------------------|---------------------------|
| Parameters        | 8 billion                 | 70 billion                |
| Performance       | Good                      | Excellent                 |
| Resource Usage    | Lower                     | Higher                    |
| Response Time     | Faster                    | Slower                    |
| Reasoning Depth   | Moderate                  | Advanced                  |
| Use Case          | Efficient deployment      | Complex reasoning tasks   |'''
        ],
        showFeedback: true,
      ),
    );

    // Another user message
    messages.add(
      MessageModel(
        id: DateTime.now().toString(),
        text: 'How would I integrate AWS Bedrock models with a RAG system?',
        time: '3:47 PM',
        isUserMessage: true,
      ),
    );

    // Set typing indicator
    isTyping.value = true;
  }

  String getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  void sendMessage() {
    if (inputController.text.trim().isEmpty) return;

    final messageText = inputController.text.trim();
    inputController.clear();

    // Add user message
    messages.add(
      MessageModel(
        id: DateTime.now().toString(),
        text: messageText,
        time: getCurrentTime(),
        isUserMessage: true,
      ),
    );

    // Set typing indicator
    isTyping.value = true;

    // Simulate AI response after delay
    Future.delayed(Duration(seconds: 2), () {
      // Generate AI response
      final aiResponse = _generateAIResponse(messageText);

      // Remove typing indicator
      isTyping.value = false;

      // Add AI response
      messages.add(
        MessageModel(
          id: DateTime.now().toString(),
          text: aiResponse,
          time: getCurrentTime(),
          isUserMessage: false,
          showFeedback: true,
        ),
      );
    });
  }

  String _generateAIResponse(String userMessage) {
    // Simplified demo response generator
    if (userMessage.toLowerCase().contains('aws') ||
        userMessage.toLowerCase().contains('bedrock')) {
      return 'To integrate AWS Bedrock models with a RAG system, you would follow these steps:\n\n'
          '1. Set up your AWS credentials and permissions for Bedrock access\n'
          '2. Create a vector database using Amazon OpenSearch or other compatible solutions\n'
          '3. Use Bedrock embedding models to generate embeddings for your documents\n'
          '4. Store these embeddings in your vector database\n'
          '5. When querying, embed the user query using the same model\n'
          '6. Retrieve relevant documents using similarity search\n'
          '7. Use Bedrock LLM (like Anthropic Claude or Titan) for generation with retrieved context\n\n'
          'AWS Bedrock offers a unified API making it particularly well-suited for RAG implementations.';
    } else {
      return 'I understand your question about "\${userMessage.substring(0, min(20, userMessage.length))}...". As a large language model, I can provide information on a wide range of topics.\n\n'
          'Could you please provide a bit more context about what specific information you\'re looking for?';
    }
  }

  int min(int a, int b) => a < b ? a : b;

  void provideFeedback(String messageId, bool isHelpful) {
    final index = messages.indexWhere((message) => message.id == messageId);
    if (index != -1) {
      messages[index].isHelpful = isHelpful;
      messages[index].showFeedback = false;
      messages.refresh();

      Toast.show(
        message: isHelpful ? 'Feedback: Helpful' : 'Feedback: Not Helpful',
        type: isHelpful ? ToastType.success : ToastType.info,
      );
    }
  }

  void changeModel() {
    // Show model selection dialog
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
                'Select Model',
                style: AppTextThemes.heading6(),
              ),
              const SizedBox(height: 20),
              _buildModelOption('Llama 3 70B'),
              _buildModelOption('Llama 3 8B'),
              _buildModelOption('Mistral 7B'),
              _buildModelOption('Titan'),
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

  Widget _buildModelOption(String modelName) {
    return InkWell(
      onTap: () {
        selectedModel.value = modelName;
        Get.back();
        Toast.show(
          message: '$modelName selected',
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
            Text(modelName, style: AppTextThemes.bodyMedium()),
            if (selectedModel.value == modelName)
              Icon(Icons.check, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
