import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:airline_app/utils/global_variable.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final List<AirlineCard>? airlines;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.airlines,
    required this.timestamp,
  });
}

class AirlineCard {
  final String name;
  final String imageUrl;
  final String rating;
  final List<String> tags;

  AirlineCard({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.tags,
  });
}

enum ChatbotType { support, general }

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final ChatbotType type;

  ChatNotifier({required this.type}) : super([]);

  void addMessage(ChatMessage message) {
    state = [...state, message];
  }

  void initializeMessages() {
    addMessage(
      ChatMessage(
        text:
            'Hello! How can I assist you today?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<bool> processUserMessage(String text) async {
    addMessage(
      ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );

    try {
      final endpoint = type == ChatbotType.support ? '/support' : '/chat';
      final response = await http.post(
        Uri.parse('$chatbotUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': text}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String reply = data['reply'];

        addMessage(
          ChatMessage(
            text: reply,
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      } else {
        addMessage(
          ChatMessage(
            text: 'Sorry, I encountered an error. Please try again.',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      addMessage(
        ChatMessage(
          text:
              'Sorry, I encountered an error. Please check your internet connection and try again.',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    }
    return true;
  }
}

final supportChatProvider =
    StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(type: ChatbotType.support),
);

final generalChatProvider =
    StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(type: ChatbotType.general),
);
