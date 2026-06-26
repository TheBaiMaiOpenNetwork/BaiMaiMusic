class Song {
  final String id;
  final String title;
  final String artist;
  final String? album;
  final String? artworkUrl;
  final Duration duration;
  final String? audioUrl;
  final String? source;
  final DateTime? addedAt;
  final bool isDownloaded;
  final String? localPath;
  final String? lyrics;

  const Song({
    required this.id, required this.title, required this.artist,
    this.album, this.artworkUrl, required this.duration,
    this.audioUrl, this.source, this.addedAt,
    this.isDownloaded = false, this.localPath, this.lyrics,
  });

  Song copyWith({
    String? id, String? title, String? artist, String? album,
    String? artworkUrl, Duration? duration, String? audioUrl,
    String? source, DateTime? addedAt, bool? isDownloaded,
    String? localPath, String? lyrics,
  }) {
    return Song(
      id: id ?? this.id, title: title ?? this.title,
      artist: artist ?? this.artist, album: album ?? this.album,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      duration: duration ?? this.duration, audioUrl: audioUrl ?? this.audioUrl,
      source: source ?? this.source, addedAt: addedAt ?? this.addedAt,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      localPath: localPath ?? this.localPath, lyrics: lyrics ?? this.lyrics,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 'title': title, 'artist': artist, 'album': album,
      'artworkUrl': artworkUrl, 'duration': duration.inSeconds,
      'audioUrl': audioUrl, 'source': source,
      'addedAt': addedAt?.toIso8601String(),
      'isDownloaded': isDownloaded, 'localPath': localPath, 'lyrics': lyrics,
    };
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String, title: json['title'] as String,
      artist: json['artist'] as String, album: json['album'] as String?,
      artworkUrl: json['artworkUrl'] as String?,
      duration: Duration(seconds: json['duration'] as int? ?? 0),
      audioUrl: json['audioUrl'] as String?, source: json['source'] as String?,
      addedAt: json['addedAt'] != null
          ? DateTime.parse(json['addedAt'] as String) : null,
      isDownloaded: json['isDownloaded'] as bool? ?? false,
      localPath: json['localPath'] as String?, lyrics: json['lyrics'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Song && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
