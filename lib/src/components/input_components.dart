import 'package:flutter/material.dart';
import 'package:bolt_ui_kit/bolt_kit.dart';

class ChatInputBox extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSend;
  final VoidCallback? onImageAttach;
  final VoidCallback? onFileAttach;
  final VoidCallback? onVoiceRecord;
  final VoidCallback? onCodeSnippet;

  const ChatInputBox({
    super.key,
    required this.controller,
    required this.onSend,
    this.onImageAttach,
    this.onFileAttach,
    this.onVoiceRecord,
    this.onCodeSnippet,
  });

  @override
  State<ChatInputBox> createState() => _ChatInputBoxState();
}

class _ChatInputBoxState extends State<ChatInputBox> {
  bool get _hasText => widget.controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border(
          top: BorderSide(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildControlButton(
                icon: Icons.image,
                onTap: widget.onImageAttach,
              ),
              _buildControlButton(
                icon: Icons.attach_file,
                onTap: widget.onFileAttach,
              ),
              _buildControlButton(
                icon: Icons.mic,
                onTap: widget.onVoiceRecord,
              ),
              _buildControlButton(
                icon: Icons.code,
                onTap: widget.onCodeSnippet,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: AppInput(
                  controller: widget.controller,
                  hint: 'Message...',
                  type: InputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              _buildSendButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          child: Icon(
            icon,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return InkWell(
      onTap: _hasText
          ? () {
              if (_hasText) {
                widget.onSend(widget.controller.text);
                widget.controller.clear();
                setState(() {});
              }
            }
          : null,
      borderRadius: BorderRadius.circular(22.5),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: _hasText
                ? [AppColors.primary, AppColors.accent]
                : [
                    AppColors.primary.withOpacity(0.5),
                    AppColors.accent.withOpacity(0.5)
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Icon(
          Icons.send,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
