import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'airportlist_expand_provider.g.dart';

@riverpod
class AirportListExpandNotifier extends _$AirportListExpandNotifier {
  @override
  bool build() {
    return false;
  }

  void toggleButton(bool toggle) {
    state = !toggle;
  }
}
