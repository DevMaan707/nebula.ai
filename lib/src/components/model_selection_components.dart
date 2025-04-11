import 'package:flutter/material.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';

class ParameterSlider extends StatelessWidget {
  final String name;
  final double value;
  final double min;
  final double max;
  final double step;
  final Function(double) onChanged;

  const ParameterSlider({
    super.key,
    required this.name,
    required this.value,
    required this.min,
    required this.max,
    this.step = 0.1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary.withOpacity(0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextThemes.caption(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.primary.withOpacity(0.7),
                    inactiveTrackColor: Colors.grey.withOpacity(0.2),
                    thumbColor: AppColors.primary,
                    trackHeight: 6,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8),
                    overlayColor: AppColors.primary.withOpacity(0.2),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 16),
                  ),
                  child: Slider(
                    value: value,
                    min: min,
                    max: max,
                    divisions: ((max - min) / step).round(),
                    onChanged: onChanged,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 24,
                alignment: Alignment.centerRight,
                child: Text(
                  value.toString(),
                  style: AppTextThemes.caption(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdvancedToggle extends StatelessWidget {
  final bool isActive;
  final Function(bool) onToggled;

  const AdvancedToggle({
    super.key,
    required this.isActive,
    required this.onToggled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggled(!isActive),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.primary.withOpacity(0.2)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Advanced Options',
                  style: AppTextThemes.bodySmall(color: Colors.grey),
                ),
              ],
            ),
            AnimatedToggle(
              isActive: isActive,
              onToggle: onToggled,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedToggle extends StatelessWidget {
  final bool isActive;
  final Function(bool) onToggle;

  const AnimatedToggle({
    Key? key,
    required this.isActive,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!isActive),
      child: Container(
        width: 42,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isActive
              ? LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isActive ? null : Colors.grey.withOpacity(0.1),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isActive ? 20 : 2,
              top: 2,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
