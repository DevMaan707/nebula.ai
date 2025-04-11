import 'package:flutter/material.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';

class ModelCard extends StatelessWidget {
  final String name;
  final String description;
  final List<String>? stats;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;

  const ModelCard({
    super.key,
    required this.name,
    required this.description,
    this.stats,
    this.badge,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(12),
        backgroundColor:
            isSelected ? AppColors.accent : AppColors.accent.withOpacity(0.7),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.smart_toy,
                      color: Colors.white, size: 22),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: AppTextThemes.bodyMedium(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextThemes.caption(color: Colors.white),
                ),
                if (stats != null && stats!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: stats!.map((stat) => _buildStat(stat)).toList(),
                  ),
                ],
              ],
            ),
            if (badge != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        badge == 'Pro' ? AppColors.primary : AppColors.warning,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge!,
                    style: AppTextThemes.caption(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String stat) {
    final List<String> parts = stat.split(' ');
    final IconData icon = parts[0] == 'Fast'
        ? Icons.bolt
        : parts[0] == 'Efficient'
            ? Icons.speed
            : Icons.smart_toy;

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            stat,
            style: AppTextThemes.caption(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class KnowledgeBaseCard extends StatelessWidget {
  final String title;
  final String description;
  final int documentCount;
  final String lastUpdated;
  final List<String> tags;
  final VoidCallback onTap;
  final VoidCallback onQuery;

  const KnowledgeBaseCard({
    super.key,
    required this.title,
    required this.description,
    required this.documentCount,
    required this.lastUpdated,
    required this.tags,
    required this.onTap,
    required this.onQuery,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: AppColors.accent.withOpacity(0.7),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextThemes.bodyMedium(fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: onQuery,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Icon(Icons.comment, size: 14, color: AppColors.accent),
                      const SizedBox(width: 4),
                      Text(
                        'Query',
                        style: AppTextThemes.caption(color: AppColors.accent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStat(Icons.description, '$documentCount Documents'),
              const SizedBox(width: 16),
              _buildStat(Icons.access_time, 'Updated $lastUpdated'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTextThemes.caption(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) => _buildTag(tag)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.primary,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTextThemes.caption(color: AppColors.accent),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag,
        style: AppTextThemes.caption(color: Colors.white),
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final String title;
  final String preview;
  final String time;
  final IconData icon;
  final Color? iconBackgroundColor;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.title,
    required this.preview,
    required this.time,
    required this.icon,
    this.iconBackgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: AppColors.accent,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: iconBackgroundColor != null
                    ? [iconBackgroundColor!, iconBackgroundColor!]
                    : [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextThemes.bodyMedium(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  preview,
                  style: AppTextThemes.caption(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: AppTextThemes.caption(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class QueryItem extends StatelessWidget {
  final String query;
  final String source;
  final String time;
  final VoidCallback onTap;

  const QueryItem({
    super.key,
    required this.query,
    required this.source,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: AppColors.primary,
            width: 3,
          ),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              query,
              style: AppTextThemes.bodySmall(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.dataset, size: 12, color: AppColors.accent),
                    const SizedBox(width: 6),
                    Text(
                      source,
                      style: AppTextThemes.caption(color: AppColors.accent),
                    ),
                  ],
                ),
                Text(
                  time,
                  style: AppTextThemes.caption(color: AppColors.accent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
