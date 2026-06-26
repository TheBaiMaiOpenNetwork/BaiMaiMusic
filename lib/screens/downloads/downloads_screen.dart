import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/localization/app_localizations.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(l10n.t('downloads')),
            actions: [
              IconButton(icon: const Icon(Icons.delete_sweep_outlined),
                onPressed: () {}, tooltip: 'Limpiar todo'),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Icon(Icons.storage, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Almacenamiento usado',
                            style: TextStyle(fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface)),
                          const SizedBox(height: 4),
                          Text('0 MB de 500 MB',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withAlpha(179),
                              fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download_done, size: 80,
                    color: theme.colorScheme.primary.withAlpha(128)),
                  const SizedBox(height: 16),
                  Text('Sin descargas aún', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('Las canciones descargadas aparecerán aquí',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(153))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
