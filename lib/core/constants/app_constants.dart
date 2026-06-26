class AppConstants {
  AppConstants._();

  static const String appName = 'BaiMai Music';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  static const String organization = 'The BaiMai Open Network';
  static const String tagline = 'Made with ♥️ by The BaiMai Open Network';
  static const String githubUrl = 'https://github.com/TheBaiMaiOpenNetwork/BaiMai-Music';
  static const String issuesUrl = 'https://github.com/TheBaiMaiOpenNetwork/BaiMai-Music/issues';

  static const String settingsBox = 'settings_box';
  static const String songsBox = 'songs_box';
  static const String playlistsBox = 'playlists_box';
  static const String downloadsBox = 'downloads_box';
  static const String cacheBox = 'cache_box';

  static const String themeModeKey = 'theme_mode';
  static const String primaryColorKey = 'primary_color';
  static const String localeKey = 'locale';
  static const String audioQualityKey = 'audio_quality';
  static const String downloadPathKey = 'download_path';
  static const String cacheSizeKey = 'max_cache_size';

  static const List<String> supportedLanguages = [
    'es', 'en', 'pt', 'fr', 'zh', 'ru', 'ja', 'de', 'it',
    'hi', 'ko', 'th', 'id', 'sv', 'fi', 'no', 'vi', 'tl',
  ];

  static const Map<String, String> languageNames = {
    'es': 'Español', 'en': 'English', 'pt': 'Português', 'fr': 'Français',
    'zh': '中文', 'ru': 'Русский', 'ja': '日本語', 'de': 'Deutsch',
    'it': 'Italiano', 'hi': 'हिन्दी', 'ko': '한국어', 'th': 'ไทย',
    'id': 'Bahasa Indonesia', 'sv': 'Svenska', 'fi': 'Suomi',
    'no': 'Norsk', 'vi': 'Tiếng Việt', 'tl': 'Filipino',
  };

  static const Map<String, String> languageFlags = {
    'es': '🇪🇸', 'en': '🇺🇸', 'pt': '🇵🇹', 'fr': '🇫🇷',
    'zh': '🇨🇳', 'ru': '🇷🇺', 'ja': '🇯🇵', 'de': '🇩🇪',
    'it': '🇮🇹', 'hi': '🇮🇳', 'ko': '🇰🇷', 'th': '🇹🇭',
    'id': '🇮🇩', 'sv': '🇸🇪', 'fi': '🇫🇮', 'no': '🇳🇴',
    'vi': '🇻🇳', 'tl': '🇵🇭',
  };

  static const int defaultCacheSizeMB = 500;
  static const int maxSearchResults = 50;
  static const Duration networkTimeout = Duration(seconds: 15);
}
