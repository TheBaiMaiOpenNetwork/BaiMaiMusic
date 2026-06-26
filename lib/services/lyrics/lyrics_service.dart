import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lyricsServiceProvider = Provider<LyricsService>((ref) {
  return LyricsService();
});

class LyricsService {
  Future<String?> fetchLyrics({required String title, required String artist}) async {
    try {
      final url = 'https://api.lyrics.ovh/v1/$artist/$title';
      final response = await http.get(
        Uri.parse(url), headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['lyrics'] as String?;
      }
      return null;
    } catch (e) { return null; }
  }
}
