<p align="center">
  <img src="assets/icons/logo.svg" width="100" alt="BaiMai Music Logo"/>
</p>

<h1 align="center">BaiMai Music</h1>
<p align="center">
  <strong>Reproductor de música moderno, privado y de código abierto</strong><br/>
  Streaming desde YouTube · Sin anuncios · Sin registro · Sin rastreadores
</p>

<p align="center">
  <a href="https://github.com/TheBaiMaiOpenNetwork/BaiMai-Music/releases/latest">
    <img src="https://img.shields.io/github/v/release/TheBaiMaiOpenNetwork/BaiMai-Music?style=flat-square&color=8B5CF6" alt="Latest Release"/>
  </a>
  <img src="https://img.shields.io/badge/Flutter-3.27%2B-02569B?style=flat-square&logo=flutter" alt="Flutter 3.27+"/>
  <img src="https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey?style=flat-square" alt="License"/>
  <img src="https://img.shields.io/badge/Platforms-Android%20%7C%20Windows%20%7C%20Linux-8B5CF6?style=flat-square" alt="Platforms"/>
</p>

---

## ✨ Características

| Función | Descripción |
|---------|-------------|
| 🎧 **Streaming** | Reproduce música directamente desde YouTube sin cuentas |
| 📥 **Offline** | Descarga canciones para escuchar sin internet |
| 🎵 **Ecualizador** | 9 presets (Bass Boost, Rock, Pop, Jazz, Clásica…) |
| 🎨 **Temas** | 8 colores primarios + modo claro/oscuro/sistema |
| 🌍 **18 Idiomas** | ES, EN, PT, FR, ZH, RU, JA, DE, IT, HI, KO, TH, ID, SV, FI, NO, VI, TL |
| 🔒 **Privacidad** | Sin anuncios, sin registro, sin rastreadores, código abierto |
| 📱 **Multiplataforma** | Android, Windows y Linux desde un solo código base |

---

## 📥 Instalación

### Android
1. Descarga el archivo `.apk` desde la [última versión](https://github.com/TheBaiMaiOpenNetwork/BaiMai-Music/releases/latest)
2. En tu Android ve a **Ajustes → Seguridad → Instalar apps desconocidas** y actívalo
3. Abre el APK y presiona **Instalar**

### Windows
1. Descarga el archivo `.zip` desde la [última versión](https://github.com/TheBaiMaiOpenNetwork/BaiMai-Music/releases/latest)
2. Descomprime la carpeta donde quieras
3. Ejecuta `baimai_music.exe`

### Linux (Ubuntu / Debian / Mint / Zorin)
```bash
# Descarga el .deb desde la última versión, luego:
sudo dpkg -i BaiMai-Music-<versión>-Linux-amd64.deb

# Si hay dependencias faltantes:
sudo apt-get install -f
```

---

## 🛠️ Compilar desde el código fuente

### Requisitos previos

| Herramienta | Versión mínima |
|-------------|----------------|
| Flutter SDK | 3.27.0 |
| Dart SDK | 3.3.0 |
| Java (Android) | 17 |
| Android SDK (Android) | API 21+ |
| Visual Studio 2022 (Windows) | con C++ Desktop |
| CMake + Ninja (Linux) | cualquiera reciente |

### Clonar y configurar

```bash
git clone https://github.com/TheBaiMaiOpenNetwork/BaiMai-Music.git
cd BaiMai-Music
flutter pub get
```

### Compilar por plataforma

**Android**
```bash
# Generar archivos de plataforma (solo la primera vez)
flutter create --project-name baimai_music --org com.baimai --platforms android .

flutter build apk --release
# APK en: build/app/outputs/flutter-apk/app-release.apk
```

**Windows**
```powershell
# Generar archivos de plataforma (solo la primera vez)
flutter create --project-name baimai_music --org com.baimai --platforms windows .

flutter build windows --release
# Ejecutable en: build\windows\x64\runner\Release\baimai_music.exe
```

**Linux**
```bash
# Instalar dependencias del sistema (Ubuntu/Debian)
sudo apt-get install -y clang cmake ninja-build pkg-config \
  libgtk-3-dev liblzma-dev libstdc++-12-dev libsecret-1-dev libjsoncpp-dev

# Generar archivos de plataforma (solo la primera vez)
flutter create --project-name baimai_music --org com.baimai --platforms linux .

flutter build linux --release
# Binario en: build/linux/x64/release/bundle/baimai_music
```

### Ejecutar en modo desarrollo

```bash
flutter run                    # plataforma detectada automáticamente
flutter run -d android         # dispositivo Android conectado
flutter run -d windows         # Windows
flutter run -d linux           # Linux
```

---

## 🏗️ Arquitectura del proyecto

```
lib/
├── main.dart                  # Punto de entrada, bootstrap
├── app.dart                   # MaterialApp + temas + localización
├── core/
│   ├── constants/             # AppConstants (URLs, claves, idiomas)
│   ├── localization/          # AppLocalizations (18 idiomas)
│   ├── providers/             # Providers globales (locale)
│   ├── security/              # SecurityManager (hash, sanitización)
│   ├── storage/               # StorageInitializer (Hive)
│   └── theme/                 # ThemeManager (Material 3)
├── models/
│   ├── song.dart              # Modelo Song con JSON serialization
│   └── playlist.dart          # Modelo Playlist
├── services/
│   ├── audio/                 # AudioPlayerService (just_audio)
│   ├── equalizer/             # EqualizerService + presets
│   ├── lyrics/                # LyricsService
│   ├── storage/               # DownloadService
│   └── youtube/               # YouTubeService (youtube_explode_dart)
├── screens/
│   ├── splash/                # SplashScreen
│   ├── home/                  # HomeScreen + tendencias
│   ├── search/                # SearchScreen + categorías
│   ├── library/               # LibraryScreen (canciones/artistas/álbumes)
│   ├── downloads/             # DownloadsScreen
│   ├── player/                # PlayerScreen (reproductor completo)
│   └── settings/              # SettingsScreen (tema, idioma, audio)
└── widgets/
    ├── common/                # BottomNavBar
    └── player/                # MiniPlayer
```

**Stack tecnológico:**
- **UI:** Flutter 3.27+ con Material 3
- **Estado:** Riverpod 2.5
- **Audio:** just_audio + audio_service (background playback)
- **YouTube:** youtube_explode_dart (sin API key)
- **Base de datos:** Hive CE (local, sin servidor)
- **Localización:** flutter_localizations (18 idiomas embebidos)

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Lee [CONTRIBUTING.md](CONTRIBUTING.md) para conocer el proceso.

Para reportar bugs o solicitar funciones, abre un [issue](https://github.com/TheBaiMaiOpenNetwork/BaiMai-Music/issues).

---

## 📄 Licencia

Este proyecto está bajo la licencia **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)**.

Puedes compartir y adaptar el material, siempre que des crédito a The BaiMai Open Network, no lo uses con fines comerciales y distribuyas tus contribuciones bajo la misma licencia.

Ver [LICENSE](LICENSE) para el texto completo.

---

<p align="center">Hecho con ♥️ por <strong>The BaiMai Open Network</strong></p>


---

## 🚀 Publicar un Release en GitHub

Para publicar una nueva versión con binarios automáticos para las 3 plataformas:

```bash
# 1. Asegúrate de que tus cambios están en main
git push origin main

# 2. Crea un tag de versión (sigue semver: v1.0.0, v1.1.0, etc.)
git tag v1.0.0
git push origin v1.0.0
```

El workflow de GitHub Actions compilará automáticamente:
- 📱 `BaiMai-Music-v1.0.0-Android.apk`
- 🪟 `BaiMai-Music-v1.0.0-Windows.zip`
- 🐧 `BaiMai-Music-v1.0.0-Linux-amd64.deb`

Y los adjuntará al Release de GitHub automáticamente.
