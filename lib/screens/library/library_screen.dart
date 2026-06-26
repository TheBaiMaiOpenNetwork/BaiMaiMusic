import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/localization/app_localizations.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: Text(l10n.t('library')),
              bottom: const TabBar(tabs: [
                Tab(text: 'Canciones'), Tab(text: 'Artistas'), Tab(text: 'Álbumes'),
              ]),
            ),
            const SliverFillRemaining(
              child: TabBarView(children: [_SongsTab(), _ArtistsTab(), _AlbumsTab()]),
            ),
          ],
        ),
      ),
    );
  }
}

class _SongsTab extends StatelessWidget {
  const _SongsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16), itemCount: 15,
      itemBuilder: (context, index) => _LibraryTile(
        title: 'Canción ${index + 1}',
        subtitle: 'Artista ${index + 1}', icon: Icons.music_note),
    );
  }
}

class _ArtistsTab extends StatelessWidget {
  const _ArtistsTab();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.85,
        crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: 10,
      itemBuilder: (context, index) => _ArtistCard(index: index),
    );
  }
}

class _AlbumsTab extends StatelessWidget {
  const _AlbumsTab();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.85,
        crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: 10,
      itemBuilder: (context, index) => _AlbumCard(index: index),
    );
  }
}

class _LibraryTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _LibraryTile({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(icon)),
      title: Text(title), subtitle: Text(subtitle),
      trailing: const Icon(Icons.more_vert), onTap: () {},
    );
  }
}

class _ArtistCard extends StatelessWidget {
  final int index;
  const _ArtistCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                  begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: const Icon(Icons.person, size: 48, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Artista ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.w600),
              maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final int index;
  const _AlbumCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.colorScheme.tertiary, theme.colorScheme.primary])),
              child: const Icon(Icons.album, size: 48, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Álbum ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.w600),
              maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
