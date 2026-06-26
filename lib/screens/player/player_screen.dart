import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/song.dart';

class PlayerScreen extends ConsumerWidget {
  final Song? song;
  const PlayerScreen({super.key, this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [theme.colorScheme.primary.withAlpha(102), theme.colorScheme.surface])),
        child: SafeArea(
          child: Column(
            children: [
              _PlayerHeader(context: context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _AlbumArt(),
                      const SizedBox(height: 32),
                      _SongInfo(song: song),
                      const SizedBox(height: 32),
                      const _ProgressBar(),
                      const SizedBox(height: 16),
                      const _PlayerControls(),
                      const SizedBox(height: 24),
                      const _PlayerActions(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerHeader extends StatelessWidget {
  final BuildContext context;
  const _PlayerHeader({required this.context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.keyboard_arrow_down, size: 32),
            onPressed: () => Navigator.pop(context)),
          const Expanded(
            child: Text('Reproduciendo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
    );
  }
}

class _AlbumArt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withAlpha(102),
                  blurRadius: 30, offset: const Offset(0, 15)),
              ]),
            child: const Icon(Icons.music_note_rounded, size: 120, color: Colors.white),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        ),
      ),
    );
  }
}

class _SongInfo extends StatelessWidget {
  final Song? song;
  const _SongInfo({this.song});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(song?.title ?? 'Sin reproducción',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text(song?.artist ?? 'Artista desconocido',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(179)),
          textAlign: TextAlign.center),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            activeTrackColor: theme.colorScheme.primary,
            inactiveTrackColor: theme.colorScheme.surfaceContainerHighest,
            thumbColor: theme.colorScheme.primary),
          child: Slider(value: 0.3, onChanged: (_) {}),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1:23', style: TextStyle(fontSize: 12)),
              Text('3:45', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayerControls extends StatelessWidget {
  const _PlayerControls();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(icon: const Icon(Icons.shuffle), onPressed: () {}, iconSize: 28),
        IconButton(icon: const Icon(Icons.skip_previous_rounded), onPressed: () {}, iconSize: 40),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle, color: theme.colorScheme.primary,
            boxShadow: [BoxShadow(
              color: theme.colorScheme.primary.withAlpha(128), blurRadius: 20)]),
          child: IconButton(icon: const Icon(Icons.play_arrow_rounded),
            color: Colors.white, onPressed: () {}, iconSize: 48),
        ),
        IconButton(icon: const Icon(Icons.skip_next_rounded), onPressed: () {}, iconSize: 40),
        IconButton(icon: const Icon(Icons.repeat), onPressed: () {}, iconSize: 28),
      ],
    );
  }
}

class _PlayerActions extends StatelessWidget {
  const _PlayerActions();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionButton(icon: Icons.lyrics, label: 'Letra'),
        _ActionButton(icon: Icons.equalizer, label: 'Ecualizador'),
        _ActionButton(icon: Icons.queue_music, label: 'Cola'),
        _ActionButton(icon: Icons.download, label: 'Descargar'),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: Icon(icon), onPressed: () {}),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
