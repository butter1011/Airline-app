import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiNotifier extends StateNotifier<Map<String, int>> {
  EmojiNotifier() : super({});

  void setEmoji(String feedbackId, int emojiIndex) {
    state = {...state, feedbackId: emojiIndex};
  }

  int? getEmoji(String feedbackId) {
    return state[feedbackId];
  }
}

final emojiProvider =
    StateNotifierProvider<EmojiNotifier, Map<String, int>>((ref) {
  return EmojiNotifier();
});
