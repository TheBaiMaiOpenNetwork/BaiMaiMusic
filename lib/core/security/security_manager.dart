import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

class SecurityManager {
  SecurityManager._();
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    debugPrint('[SecurityManager] Initialized');
  }

  static String hashData(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String sanitizeInput(String input) {
    return input
        .replaceAll(RegExp(r'[<>]'), '')
        .replaceAll(RegExp(r'javascript:', caseSensitive: false), '')
        .trim();
  }

  static bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    final allowedSchemes = ['https', 'http'];
    if (!allowedSchemes.contains(uri.scheme)) return false;
    return true;
  }

  static void logError(String error) {
    if (kDebugMode) {
      debugPrint('[Error] ${hashData(error).substring(0, 8)}');
    }
  }

  static String generateSessionToken() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = DateTime.now().microsecondsSinceEpoch;
    return hashData('$timestamp-$random');
  }
}
