import 'package:flutter/material.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';

class UploadDocumentCard extends StatelessWidget {
  final VoidCallback onTap;

  const UploadDocumentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(12),
      borderColor: AppColors.primary.withOpacity(0.5),
      backgroundColor: AppColors.accent.withOpacity(0.7),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.file_upload,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Upload documents',
              style: AppTextThemes.bodyMedium(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Upload PDF, TXT, DOCX, or MD files to create a new knowledge base or add to existing ones',
              style: AppTextThemes.caption(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Button(
              text: 'Select Files',
              type: ButtonType.primary,
              onPressed: onTap,
              size: ButtonSize.small,
            ),
          ],
        ),
      ),
    );
  }
}

class KnowledgeBaseOption extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const KnowledgeBaseOption({
    Key? key,
    required this.text,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.2)
              : AppColors.accent.withOpacity(0.7),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: AppTextThemes.caption(
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmbeddingModelCard extends StatelessWidget {
  final String name;
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const EmbeddingModelCard({
    Key? key,
    required this.name,
    required this.type,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(10),
      backgroundColor: AppColors.accent.withOpacity(0.7),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(Icons.crop_square, color: Colors.white, size: 15),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextThemes.bodySmall(fontWeight: FontWeight.w500),
                ),
                Text(
                  type,
                  style: AppTextThemes.caption(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: isSelected
                ? Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
