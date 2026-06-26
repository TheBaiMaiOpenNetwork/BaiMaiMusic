import 'package:just_audio/just_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/song.dart';

final audioPlayerServiceProvider = Provider<AudioPlayerService>((ref) {
  final service = AudioPlayerService();
  ref.onDispose(() => service.dispose());
  return service;
});

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();
  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: []);

  AudioPlayerService() { _init(); }

  void _init() { _player.setAudioSource(_playlist, preload: false); }

  AudioPlayer get player => _player;
  bool get isPlaying => _player.playing;
  Duration? get duration => _player.duration;
  Duration get position => _player.position;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<int?> get currentIndexStream => _player.currentIndexStream;

  Future<void> playSong(Song song) async {
    try {
      AudioSource source;
      if (song.isDownloaded && song.localPath != null) {
        source = AudioSource.file(song.localPath!, tag: song);
      } else if (song.audioUrl != null) {
        source = AudioSource.uri(Uri.parse(song.audioUrl!), tag: song);
      } else {
        return;
      }
      await _player.setAudioSource(source);
      await _player.play();
    } catch (e) { rethrow; }
  }

  Future<void> addToQueue(Song song) async {
    AudioSource source;
    if (song.isDownloaded && song.localPath != null) {
      source = AudioSource.file(song.localPath!, tag: song);
    } else if (song.audioUrl != null) {
      source = AudioSource.uri(Uri.parse(song.audioUrl!), tag: song);
    } else { return; }
    await _playlist.add(source);
  }

  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();
  Future<void> stop() => _player.stop();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> setVolume(double volume) => _player.setVolume(volume);

  Future<void> seekToNext() async {
    if (_player.hasNext) await _player.seekToNext();
  }

  Future<void> seekToPrevious() async {
    if (_player.hasPrevious) await _player.seekToPrevious();
  }

  Future<void> setShuffleModeEnabled(bool enabled) =>
      _player.setShuffleModeEnabled(enabled);
  Future<void> setLoopMode(LoopMode mode) => _player.setLoopMode(mode);

  Future<void> dispose() async { await _player.dispose(); }
}
