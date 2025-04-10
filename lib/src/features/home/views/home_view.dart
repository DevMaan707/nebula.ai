import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:nebula_ai/src/controllers/home_controller.dart';
import 'package:nebula_ai/src/components/card_components.dart';
import 'package:nebula_ai/src/components/navigation_components.dart';

import '../../../helpers.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingSection(),
              _buildModelSection(),
              _buildRecentChatsSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: NewChatButton(
        onPressed: controller.createNewChat,
      ),
      bottomNavigationBar: Obx(() => NebulaBottomNavBar(
            currentIndex: controller.selectedTabIndex.value,
            onTabChanged: controller.changeTab,
          )),
    );
  }

  Widget _buildGreetingSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, John',
            style: AppTextThemes.heading4(),
          ),
          Text(
            'Which AI model would you like to use today?',
            style: AppTextThemes.bodyMedium(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildModelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(Icons.memory, color: AppColors.primary, size: 16),
              const SizedBox(width: 8),
              Text(
                'Available Models',
                style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() => GridView.builder(
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
                  final model = controller.models[index];
                  return ModelCard(
                    name: model['name'],
                    description: model['description'],
                    stats: model['stats'],
                    badge: model['badge'],
                    isSelected: model['isSelected'],
                    onTap: () => controller.selectModel(index),
                  );
                },
              )),
        ),
      ],
    );
  }

  Widget _buildRecentChatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(Icons.history, color: AppColors.primary, size: 16),
              const SizedBox(width: 8),
              Text(
                'Recent Chats',
                style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() => Column(
                children: List.generate(
                  controller.recentChats.length,
                  (index) {
                    final chat = controller.recentChats[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ChatListItem(
                        title: chat['title'],
                        preview: chat['preview'],
                        time: chat['time'],
                        icon: chat['icon'],
                        iconBackgroundColor: chat['iconBackground'],
                        onTap: () => controller.openChat(index),
                      ),
                    );
                  },
                ),
              )),
        ),
      ],
    );
  }
}
