# Changelog

All notable changes to BaiMai Music are documented here.

## [1.0.0] - 2026-06-25

### Initial Release
- 🎧 Streaming de audio desde YouTube via youtube_explode_dart
- 📥 Descarga de canciones para modo offline
- 🎵 Ecualizador con 9 presets (Bass Boost, Rock, Pop, Jazz, etc.)
- 🎨 Tema personalizable con 8 colores primarios
- 🌍 18 idiomas soportados
- 🔒 Privacidad total: sin anuncios, sin registro, sin rastreadores
- 📱 Soporte multiplataforma: Android, Windows, Linux
- 🗄️ Base de datos local con Hive CE
- 🔄 Estado reactivo con Riverpod
- 🎙️ Letras de canciones integradas

### Fixes (v1.0.0)
- Migración de `withOpacity()` depreciado a `withAlpha()` en Flutter 3.27+
- Eliminación de `surfaceVariant` depreciado (reemplazado por `surfaceContainerHighest`)
- Corrección del workflow de CI/CD: `flutter create` ya no sobreescribe el código Dart
- Soporte correcto de assets en pubspec.yaml (images/, fonts/)
- Test de widget actualizado para BaiMai Music
- Reglas adicionales de análisis estático para mejor calidad de código
