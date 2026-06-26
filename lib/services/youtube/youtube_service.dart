import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/song.dart';

final youtubeServiceProvider = Provider<YouTubeService>((ref) {
  final service = YouTubeService();
  ref.onDispose(() => service.dispose());
  return service;
});

enum AudioQuality { low, medium, high, highest }

class YouTubeService {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<List<Song>> searchSongs(String query) async {
    try {
      final results = await _yt.search.search(query);
      return results.where((v) => v.duration != null).map(_videoToSong).toList();
    } catch (e) { return []; }
  }

  Future<String?> getAudioStreamUrl(String videoId,
      {AudioQuality quality = AudioQuality.high}) async {
    try {
      final manifest = await _yt.videos.streamsClient.getManifest(videoId);
      final audioStreams = manifest.audioOnly;
      if (audioStreams.isEmpty) return null;
      final stream = _selectStreamByQuality(audioStreams, quality);
      return stream.url.toString();
    } catch (e) { return null; }
  }

  AudioOnlyStreamInfo _selectStreamByQuality(
      AudioOnlyStreamInfoList streams, AudioQuality quality) {
    switch (quality) {
      case AudioQuality.low: return streams.withLowestBitrate();
      case AudioQuality.medium: return streams.toList()[streams.length ~/ 2];
      case AudioQuality.high: return streams.withHighestBitrate();
      case AudioQuality.highest: return streams.withHighestBitrate();
    }
  }

  Future<Song?> getSongDetails(String videoId) async {
    try {
      final video = await _yt.videos.get(videoId);
      return _videoToSong(video);
    } catch (e) { return null; }
  }

  Song _videoToSong(Video video) {
    return Song(
      id: video.id.value, title: video.title, artist: video.author,
      artworkUrl: video.thumbnails.highResUrl,
      duration: video.duration ?? Duration.zero, source: 'youtube',
    );
  }

  void dispose() { _yt.close(); }
}
