import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveFeedItem {
  final String userName;
  final String entityName;
  final String type;
  final int? rating;
  final String comment;
  final DateTime timeStamp;

  LiveFeedItem({
    required this.userName,
    required this.entityName,
    required this.type,
    required this.rating,
    required this.comment,
    required this.timeStamp,
  });
}

final liveFeedProvider =
    StateNotifierProvider<LiveFeedNotifier, List<LiveFeedItem>>((ref) {
  return LiveFeedNotifier();
});

class LiveFeedNotifier extends StateNotifier<List<LiveFeedItem>> {
  LiveFeedNotifier() : super([]);
  static const int maxItems = 5; // Maximum number of items to show

  void addFeedItem(LiveFeedItem item) {
    if (state.length >= maxItems) {
      state = [item, ...state.sublist(0, maxItems - 1)];
    } else {
      state = [item, ...state];
    }
  }
}
