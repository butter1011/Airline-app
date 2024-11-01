import 'package:airline_app/utils/airport_list_json.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemSelectionProvider =
    StateNotifierProvider<ItemSelectionNotifier, List<List<bool>>>((ref) {
  return ItemSelectionNotifier(aspectsForElevation);
});

class ItemSelectionNotifier extends StateNotifier<List<List<bool>>> {
  ItemSelectionNotifier(Map<String, dynamic> aspects)
      : super(aspects.entries.map((aspect) {
          // Create a selection list for each aspect based on its items
          return List.generate(aspect.value['items'].length, (index) => false);
        }).toList());

  void toggleSelection(int aspectIndex, int itemIndex) {
    state = [
      for (int i = 0; i < state.length; i++)
        i == aspectIndex
            ? [
                for (int j = 0; j < state[i].length; j++)
                  j == itemIndex ? !state[i][j] : state[i][j],
              ]
            : state[i],
    ];
  }

  int selectedNumber(int aspectIndex) {
    int selection = 0;
    for (bool index in state[aspectIndex]) {
      if (index == true) {
        selection++;
      }
    }
    return selection;
  }

   int numberOfSelectedAspects() {
    int count = 0;
    for (List<bool> aspect in state) {
      if (aspect.any((isSelected) => isSelected)) {
        count++;
      }
    }
    return count;
  }
}
