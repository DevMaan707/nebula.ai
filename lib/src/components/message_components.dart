import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helpers.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isUserMessage;
  final List<Widget>? codeSamples;
  final List<Widget>? feedbackOptions;

  const MessageBubble({
    super.key,
    required this.message,
    required this.time,
    this.isUserMessage = false,
    this.codeSamples,
    this.feedbackOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: isUserMessage
              ? LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isUserMessage ? null : AppColors.accent,
          borderRadius: BorderRadius.circular(16.0).copyWith(
            bottomRight: isUserMessage ? const Radius.circular(4.0) : null,
            bottomLeft: !isUserMessage ? const Radius.circular(4.0) : null,
          ),
          border: !isUserMessage
              ? Border.all(color: AppColors.primary.withOpacity(0.2))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUserMessage)
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(Icons.smart_toy, color: Colors.white, size: 10),
                  ),
                  const SizedBox(width: 6),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: Text('AI Assistant',
                        style: AppTextThemes.caption(color: Colors.white)),
                  ),
                ],
              ),
            if (!isUserMessage) const SizedBox(height: 8),
            Text(
              message,
              style: AppTextThemes.bodyMedium(),
            ),
            if (codeSamples != null) ...codeSamples!,
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: AppTextThemes.caption(
                  color: isUserMessage
                      ? Colors.white.withOpacity(0.7)
                      : Colors.grey,
                ),
              ),
            ),
            if (feedbackOptions != null && !isUserMessage)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: feedbackOptions!,
              ),
          ],
        ),
      ),
    );
  }
}

class CodeBlock extends StatelessWidget {
  final String code;
  final String? language;

  const CodeBlock({
    super.key,
    required this.code,
    this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Helpers.backgroundDark,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language ?? 'Code',
                  style: AppTextThemes.caption(color: Colors.grey),
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code));
                    Toast.show(
                      message: 'Code copied to clipboard',
                      type: ToastType.info,
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.copy, size: 14, color: AppColors.accent),
                      const SizedBox(width: 4),
                      Text(
                        'Copy',
                        style: AppTextThemes.caption(color: AppColors.accent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                code,
                //style: AppTextThemes.codeBlock(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SystemMessage extends StatelessWidget {
  final String message;

  const SystemMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Helpers.surfacePrimary.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        message,
        style: AppTextThemes.caption(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          3,
          (index) => _buildDot(index),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const AnimatedPulse(),
    );
  }
}

class AnimatedPulse extends StatefulWidget {
  const AnimatedPulse({Key? key}) : super(key: key);

  @override
  _AnimatedPulseState createState() => _AnimatedPulseState();
}

class _AnimatedPulseState extends State<AnimatedPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -4 * sin(_animation.value * 3.14)),
          child: Opacity(
            opacity: 0.6 + 0.4 * sin(_animation.value * 3.14),
            child: Container(),
          ),
        );
      },
    );
  }
}

class FeedbackButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool isActive;

  const FeedbackButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: isActive ? AppColors.accent : Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: AppTextThemes.caption(
                color: isActive ? AppColors.accent : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
