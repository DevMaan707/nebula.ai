import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:nebula_ai/src/controllers/rag_controller.dart';
import 'package:nebula_ai/src/components/navigation_components.dart';
import 'package:nebula_ai/src/components/card_components.dart';
import 'package:nebula_ai/src/components/knowledge_base_components.dart';

import '../../../components/app_bar.dart';
import '../../../helpers.dart';

class RagView extends StatelessWidget {
  RagView({Key? key}) : super(key: key);

  final RagController controller = Get.put(RagController());

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
              _buildKnowledgeBasesSection(),
              _buildUploadSection(),
              _buildRecentQueriesSection(),
              _buildEmbeddingModelsSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: controller.createNewKnowledgeBase,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Obx(() => NebulaBottomNavBar(
            currentIndex: controller.selectedTabIndex.value,
            onTabChanged: controller.changeTab,
          )),
    );
  }

  Widget _buildKnowledgeBasesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(Icons.dataset, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Your Knowledge Bases',
                style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() => Column(
                children: List.generate(
                  controller.knowledgeBases.length,
                  (index) {
                    final kb = controller.knowledgeBases[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: KnowledgeBaseCard(
                        title: kb['title'],
                        description: kb['description'],
                        documentCount: kb['documentCount'],
                        lastUpdated: kb['lastUpdated'],
                        tags: List<String>.from(kb['tags']),
                        onTap: () {},
                        onQuery: () => controller.queryKnowledgeBase(index),
                      ),
                    );
                  },
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Icon(Icons.cloud_upload, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Add Knowledge',
                style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: UploadDocumentCard(
            onTap: controller.uploadDocuments,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentQueriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Icon(Icons.history, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Recent Queries',
                style: AppTextThemes.bodyLarge(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() => Column(
                children: List.generate(
                  controller.recentQueries.length,
                  (index) {
                    final query = controller.recentQueries[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: QueryItem(
                        query: query['query'],
                        source: query['source'],
                        time: query['time'],
                        onTap: () => controller.viewRecentQuery(index),
                      ),
                    );
                  },
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildEmbeddingModelsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Icon(Icons.memory, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Embedding Models',
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
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.embeddingModels.length,
                itemBuilder: (context, index) {
                  final model = controller.embeddingModels[index];
                  return EmbeddingModelCard(
                    name: model['name'],
                    type: model['type'],
                    isSelected: model['selected'],
                    onTap: () => controller.selectEmbeddingModel(index),
                  );
                },
              )),
        ),
      ],
    );
  }
}
