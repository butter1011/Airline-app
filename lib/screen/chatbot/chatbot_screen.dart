import 'package:airline_app/screen/chatbot/widgets/received_message_box.dart';
import 'package:airline_app/screen/chatbot/widgets/sent_message_box.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // Use IconButton for better control
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
          },
          icon: const Icon(Icons.arrow_back_ios,
              size: 20), // Slightly smaller icon
        ),
        centerTitle: true,
        title: FittedBox(
          // Use FittedBox to handle long titles
          fit: BoxFit.scaleDown,
          child: Text(
            "Sam-AI Flight Planner",
            style: AppStyles.textStyle_16_600,
            overflow:
                TextOverflow.ellipsis, // Add ellipsis for very long titles
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 4,
                color: AppStyles.littleBlackColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView(
                    reverse: true,
                    children: const [
                      SizedBox(height: 100), // Space for visual separation
                      SentMessageBox(),
                      SizedBox(height: 32),
                      ReceivedMessageBox(),
                      SizedBox(height: 40),
                      SentMessageBox(),
                      SizedBox(height: 32),
                      ReceivedMessageBox(),
                      SizedBox(height: 40),
                      SentMessageBox(),
                      SizedBox(height: 32),
                      ReceivedMessageBox(),
                      SizedBox(height: 40), // Space for visual separation
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildMessageInputField(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputField(BuildContext context) {
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
              decoration: InputDecoration(
                hintText: 'Message',
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
            onPressed: () {
              // Implement send message functionality
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Message sent!'))); // Placeholder for actual send action
            },
          ),
        ],
      ),
    );
  }
}
