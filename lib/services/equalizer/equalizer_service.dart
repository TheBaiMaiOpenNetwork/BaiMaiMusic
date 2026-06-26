import 'package:flutter_riverpod/flutter_riverpod.dart';

final equalizerProvider = StateNotifierProvider<EqualizerNotifier, EqualizerState>((ref) {
  return EqualizerNotifier();
});

class EqualizerState {
  final List<double> bands;
  final bool enabled;
  final String? preset;

  const EqualizerState({
    this.bands = const [0, 0, 0, 0, 0],
    this.enabled = false, this.preset,
  });

  EqualizerState copyWith({List<double>? bands, bool? enabled, String? preset}) {
    return EqualizerState(
      bands: bands ?? this.bands, enabled: enabled ?? this.enabled,
      preset: preset ?? this.preset,
    );
  }
}

class EqualizerNotifier extends StateNotifier<EqualizerState> {
  EqualizerNotifier() : super(const EqualizerState());

  static const Map<String, List<double>> presets = {
    'Flat': [0, 0, 0, 0, 0],
    'Bass Boost': [8, 5, 0, -2, -3],
    'Treble Boost': [-3, -2, 0, 5, 8],
    'Vocal': [-2, 0, 4, 3, 0],
    'Rock': [5, 3, -2, 3, 6],
    'Pop': [-1, 2, 5, 2, -1],
    'Jazz': [3, 0, 2, 0, 3],
    'Classical': [4, 3, 2, 3, 4],
    'Electronic': [6, 4, 0, 4, 6],
  };

  void setEnabled(bool enabled) { state = state.copyWith(enabled: enabled); }

  void setBand(int index, double value) {
    final newBands = List<double>.from(state.bands);
    newBands[index] = value;
    state = state.copyWith(bands: newBands, preset: null);
  }

  void applyPreset(String presetName) {
    final preset = presets[presetName];
    if (preset != null) {
      state = state.copyWith(bands: preset, preset: presetName, enabled: true);
    }
  }

  void reset() { state = const EqualizerState(); }
}
