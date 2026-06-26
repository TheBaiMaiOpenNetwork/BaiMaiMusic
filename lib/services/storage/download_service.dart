import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/song.dart';

final downloadServiceProvider = Provider<DownloadService>((ref) {
  return DownloadService();
});

class DownloadService {
  Future<Directory> getDownloadDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final musicDir = Directory('${dir.path}/BaiMaiMusic');
    if (!await musicDir.exists()) {
      await musicDir.create(recursive: true);
    }
    return musicDir;
  }

  Future<String?> downloadSong(Song song, String audioUrl) async {
    try {
      final dir = await getDownloadDirectory();
      final safeName = _sanitizeFilename('${song.artist} - ${song.title}');
      final filePath = '${dir.path}/$safeName.mp3';
      final response = await http.get(Uri.parse(audioUrl));
      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      }
      return null;
    } catch (e) { return null; }
  }

  Future<bool> deleteDownload(String localPath) async {
    try {
      final file = File(localPath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) { return false; }
  }

  Future<int> getCacheSize() async {
    try {
      final dir = await getDownloadDirectory();
      int total = 0;
      await for (final entity in dir.list()) {
        if (entity is File) total += await entity.length();
      }
      return total;
    } catch (e) { return 0; }
  }

  Future<void> clearCache() async {
    try {
      final dir = await getDownloadDirectory();
      await for (final entity in dir.list()) {
        if (entity is File) await entity.delete();
      }
    } catch (e) {}
  }

  String _sanitizeFilename(String name) {
    return name
        .replaceAll(RegExp(r'[<>:"/\\|?*]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .substring(0, name.length > 100 ? 100 : name.length);
  }
}
