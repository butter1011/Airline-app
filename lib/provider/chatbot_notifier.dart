import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([]);

  void addMessage(ChatMessage message) {
    state = [...state, message];
  }

  Future<void> processUserMessage(String text) async {
    addMessage(
      ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/chat'), // Use this for Android emulator
        // Uri.parse('http://localhost:5000/chat'),  // Use this for iOS simulator
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': text}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String reply = data['reply'];

        if (text.toLowerCase().contains('airline')) {
          addMessage(
            ChatMessage(
              text: reply,
              isUser: false,
              airlines: [
                AirlineCard(
                  name: 'Emirates Airlines',
                  imageUrl: 'https://example.com/emirates.jpg',
                  rating: '4.8',
                  tags: ['First Class', 'Good Food', 'Best Staff'],
                ),
                AirlineCard(
                  name: 'Abu Dhabi Airport',
                  imageUrl: 'https://example.com/abudhabi.jpg',
                  rating: '4.6',
                  tags: ['Clean', 'Fast Service'],
                ),
              ],
              timestamp: DateTime.now(),
            ),
          );
        } else {
          addMessage(
            ChatMessage(
              text: reply,
              isUser: false,
              timestamp: DateTime.now(),
            ),
          );
        }
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
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(),
);
