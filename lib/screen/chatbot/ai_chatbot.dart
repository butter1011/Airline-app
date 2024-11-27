import 'package:airline_app/provider/chatbot_notifier.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _formatTime(DateTime timestamp) {
    return DateFormat('h:mm a').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(4),
            child: Container(height: 4, color: AppStyles.littleBlackColor)),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppLocalizations.of(context).translate('Sam-AI Flight Planner'),
            style: AppStyles.textStyle_16_600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageWidget(message);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageWidget(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 40,
              height: 40,
              decoration: AppStyles.circleDecoration,
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/icons/bot.png'),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: message.isUser ? AppStyles.mainColor : Colors.white,
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topLeft: message.isUser
                          ? const Radius.circular(15)
                          : Radius.zero,
                      topRight: message.isUser
                          ? Radius.zero
                          : const Radius.circular(15),
                      bottomLeft: const Radius.circular(15),
                      bottomRight: const Radius.circular(15),
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(2, 2))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.text,
                          style: AppStyles.textStyle_15_500.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              _formatTime(message.timestamp),
                              style: AppStyles.textStyle_15_500.copyWith(
                                color: message.isUser
                                    ? const Color(0xff22762C)
                                    : const Color(0xff97A09C),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 8,
                  child: Icon(
                    Icons.check,
                    color: message.isUser
                        ? const Color(0xff22762C)
                        : const Color(0xff97A09C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black26),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF4CAF50)),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        ref
                            .read(chatProvider.notifier)
                            .processUserMessage(_controller.text);
                        _controller.clear();
                        _scrollToBottom();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
