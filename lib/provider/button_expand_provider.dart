import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'button_expand_provider.g.dart';

@riverpod
class ButtonExpandNotifier extends _$ButtonExpandNotifier {
  @override
  bool build() {
    return false;
  }

  void toggleButton(bool toggle) {
    state = !toggle;
  }
}
