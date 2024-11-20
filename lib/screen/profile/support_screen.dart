import 'package:airline_app/screen/profile/widget/support_received_message_box.dart';
import 'package:airline_app/screen/profile/widget/support_sent_message_box.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:airline_app/utils/app_localizations.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});


AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(AppLocalizations.of(context).translate('Support'),
          style: AppStyles.textStyle_16_600.copyWith(color: Colors.black)),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(color: Colors.black, height: 4.0),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppBar(context),
      body: Stack(
        children: [
          Column(
            children: [
            
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView(
                    reverse: true,
                    children: const [
                      SizedBox(height: 100),
                      SupportSentMessageBox(),
                      SizedBox(height: 32),
                      SupportReceivedMessageBox(),
                      SizedBox(height: 100), // Space for visual separation
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
