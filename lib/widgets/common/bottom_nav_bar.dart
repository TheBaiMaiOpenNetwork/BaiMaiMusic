import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        NavigationDestination(icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home), label: l10n.t('home')),
        NavigationDestination(icon: const Icon(Icons.search_outlined),
          selectedIcon: const Icon(Icons.search), label: l10n.t('search')),
        NavigationDestination(icon: const Icon(Icons.library_music_outlined),
          selectedIcon: const Icon(Icons.library_music), label: l10n.t('library')),
        NavigationDestination(icon: const Icon(Icons.download_outlined),
          selectedIcon: const Icon(Icons.download), label: l10n.t('downloads')),
        NavigationDestination(icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings), label: l10n.t('settings')),
      ],
    );
  }
}
