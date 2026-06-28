import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/localization/app_localizations.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _hasSearched = false;

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(title: Text(l10n.t('search'))),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: l10n.t('search_hint'),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(icon: const Icon(Icons.clear),
                          onPressed: () { _controller.clear(); setState(() => _hasSearched = false); })
                      : null),
                onChanged: (v) => setState(() {}),
                onSubmitted: (_) => _performSearch(),
              ),
            ),
          ),
          if (!_hasSearched)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categorías',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: [
                        'Pop', 'Rock', 'Hip-Hop', 'Electrónica', 'Jazz', 'Clásica',
                        'Reggaetón', 'Indie', 'R&B', 'Country', 'Metal', 'Latina',
                      ].map((c) => _CategoryChip(category: c)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          if (_hasSearched)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _SearchResultTile(index: index),
                childCount: 20),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  void _performSearch() {
    if (_controller.text.isNotEmpty) setState(() => _hasSearched = true);
  }
}

class _CategoryChip extends StatelessWidget {
  final String category;
  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ActionChip(
      label: Text(category), onPressed: () {},
      backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final int index;
  const _SearchResultTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        width: 56, height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary.withOpacity(0.7),
              theme.colorScheme.secondary.withOpacity(0.7)]),
          borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.music_note, color: Colors.white),
      ),
      title: Text('Resultado ${index + 1}'),
      subtitle: const Text('Artista'),
      trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      onTap: () {},
    );
  }
}
