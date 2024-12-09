import 'package:airline_app/provider/chatbot_notifier.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
    (ref) => ChatNotifier(type: ChatbotType.general),
  );

  String _formatTime(DateTime timestamp) {
    return DateFormat('h:mm a').format(timestamp);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatProvider.notifier).initializeMessages();
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
          },
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
            AppLocalizations.of(context).translate('Sam-AI Flight Planner'),
            style: AppStyles.textStyle_16_600.copyWith(color: Colors.black)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.black, height: 4.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == 0 && _isLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: LoadingBallWidget(),
                        ),
                      ],
                    ),
                  );
                }
                final messageIndex = _isLoading ? index - 1 : index;
                final message = messages[messages.length - 1 - messageIndex];
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
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(2, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: AppStyles.textStyle_14_400
                    .copyWith(color: Color(0xff38433E)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  _isLoading = true;
                });

                _scrollToBottom();
                final _text = _controller.text;
                _controller.clear();
                await ref.read(chatProvider.notifier).processUserMessage(_text);

                setState(() {
                  _isLoading = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
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
