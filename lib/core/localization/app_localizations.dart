import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('es'), Locale('en'), Locale('pt'), Locale('fr'),
    Locale('zh'), Locale('ru'), Locale('ja'), Locale('de'),
    Locale('it'), Locale('hi'), Locale('ko'), Locale('th'),
    Locale('id'), Locale('sv'), Locale('fi'), Locale('no'),
    Locale('vi'), Locale('tl'),
  ];

  String t(String key) {
    return _translations[locale.languageCode]?[key] ??
        _translations['en']?[key] ?? key;
  }

  static const Map<String, Map<String, String>> _translations = {
    'es': {
      'app_title': 'BaiMai Music', 'home': 'Inicio', 'search': 'Buscar',
      'library': 'Biblioteca', 'settings': 'Configuración', 'downloads': 'Descargas',
      'play': 'Reproducir', 'pause': 'Pausar', 'next': 'Siguiente',
      'previous': 'Anterior', 'shuffle': 'Aleatorio', 'repeat': 'Repetir',
      'equalizer': 'Ecualizador', 'lyrics': 'Letras', 'offline_mode': 'Modo sin conexión',
      'theme': 'Tema', 'language': 'Idioma', 'about': 'Acerca de',
      'privacy_policy': 'Política de Privacidad', 'made_with': 'Hecho con ♥️ por',
      'search_hint': 'Buscar canciones, artistas...', 'trending': 'Tendencias',
      'new_releases': 'Nuevos Lanzamientos', 'popular_playlists': 'Playlists Populares',
      'download': 'Descargar', 'downloading': 'Descargando...', 'delete': 'Eliminar',
      'cancel': 'Cancelar', 'ok': 'Aceptar', 'error': 'Error', 'success': 'Éxito',
      'no_results': 'Sin resultados', 'loading': 'Cargando...', 'appearance': 'Apariencia',
      'general': 'General', 'audio_quality': 'Calidad de Audio', 'storage': 'Almacenamiento',
      'clear_cache': 'Limpiar Caché', 'source_code': 'Código Fuente', 'version': 'Versión',
      'queue': 'Cola', 'add_to_playlist': 'Añadir a playlist', 'share': 'Compartir',
      'sleep_timer': 'Temporizador',
    },
    'en': {
      'app_title': 'BaiMai Music', 'home': 'Home', 'search': 'Search',
      'library': 'Library', 'settings': 'Settings', 'downloads': 'Downloads',
      'play': 'Play', 'pause': 'Pause', 'next': 'Next', 'previous': 'Previous',
      'shuffle': 'Shuffle', 'repeat': 'Repeat', 'equalizer': 'Equalizer',
      'lyrics': 'Lyrics', 'offline_mode': 'Offline Mode', 'theme': 'Theme',
      'language': 'Language', 'about': 'About', 'privacy_policy': 'Privacy Policy',
      'made_with': 'Made with ♥️ by', 'search_hint': 'Search songs, artists...',
      'trending': 'Trending', 'new_releases': 'New Releases',
      'popular_playlists': 'Popular Playlists', 'download': 'Download',
      'downloading': 'Downloading...', 'delete': 'Delete', 'cancel': 'Cancel',
      'ok': 'OK', 'error': 'Error', 'success': 'Success', 'no_results': 'No results',
      'loading': 'Loading...', 'appearance': 'Appearance', 'general': 'General',
      'audio_quality': 'Audio Quality', 'storage': 'Storage',
      'clear_cache': 'Clear Cache', 'source_code': 'Source Code', 'version': 'Version',
      'queue': 'Queue', 'add_to_playlist': 'Add to playlist', 'share': 'Share',
      'sleep_timer': 'Sleep Timer',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppConstants.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
