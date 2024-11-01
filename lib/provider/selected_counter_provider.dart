import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemSelectionProvider =
    StateNotifierProvider<ItemSelectionNotifier, List<bool>>((ref) {
  return ItemSelectionNotifier(4); // Replace with your actual item count
});

class ItemSelectionNotifier extends StateNotifier<List<bool>> {
  ItemSelectionNotifier(int itemCount)
      : super(List.generate(itemCount, (index) => false));

  void toggleSelection(int index) {
    state = [
      for (int i = 0; i < state.length; i++) i == index ? !state[i] : state[i],
    ];
  }

  int get selectedCount => state.where((selected) => selected).length;
}
