import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/theme_manager.dart';
import '../../core/providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final primaryColor = ref.watch(primaryColorProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(title: Text(l10n.t('settings'))),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: l10n.t('appearance')),
                  _SettingsCard(children: [
                    _ThemeModeTile(current: themeMode),
                    _PrimaryColorTile(current: primaryColor),
                  ]),
                  const SizedBox(height: 24),
                  _SectionHeader(title: l10n.t('general')),
                  _SettingsCard(children: [
                    _LanguageTile(current: locale),
                    const _AudioQualityTile(),
                    const _StorageTile(),
                  ]),
                  const SizedBox(height: 24),
                  _SectionHeader(title: l10n.t('about')),
                  _SettingsCard(children: [
                    const _PrivacyPolicyTile(),
                    const _SourceCodeTile(),
                    const _AboutTile(),
                  ]),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Text(AppConstants.tagline,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('v${AppConstants.appVersion}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
                            fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(title.toUpperCase(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary, letterSpacing: 1.2)),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(margin: EdgeInsets.zero, child: Column(children: children));
  }
}

class _ThemeModeTile extends ConsumerWidget {
  final ThemeMode current;
  const _ThemeModeTile({required this.current});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: const Text('Tema'),
      subtitle: Text(_themeName(current)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showThemeDialog(context, ref),
    );
  }

  String _themeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system: return 'Sistema';
      case ThemeMode.light: return 'Claro';
      case ThemeMode.dark: return 'Oscuro';
    }
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Seleccionar tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(title: const Text('Sistema'),
              value: ThemeMode.system, groupValue: current,
              onChanged: (v) { ref.read(themeModeProvider.notifier).state = v!; Navigator.pop(context); }),
            RadioListTile<ThemeMode>(title: const Text('Claro'),
              value: ThemeMode.light, groupValue: current,
              onChanged: (v) { ref.read(themeModeProvider.notifier).state = v!; Navigator.pop(context); }),
            RadioListTile<ThemeMode>(title: const Text('Oscuro'),
              value: ThemeMode.dark, groupValue: current,
              onChanged: (v) { ref.read(themeModeProvider.notifier).state = v!; Navigator.pop(context); }),
          ],
        ),
      ),
    );
  }
}

class _PrimaryColorTile extends ConsumerWidget {
  final Color current;
  const _PrimaryColorTile({required this.current});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.color_lens_outlined),
      title: const Text('Color principal'),
      subtitle: const Text('Morado (predeterminado)'),
      trailing: Container(width: 28, height: 28,
        decoration: BoxDecoration(color: current, shape: BoxShape.circle,
          border: Border.all(color: Colors.white24))),
      onTap: () => _showColorPicker(context, ref),
    );
  }

  void _showColorPicker(BuildContext context, WidgetRef ref) {
    final colors = [
      const Color(0xFF8B5CF6), const Color(0xFF3B82F6),
      const Color(0xFF10B981), const Color(0xFFF59E0B),
      const Color(0xFFEF4444), const Color(0xFFEC4899),
      const Color(0xFF6366F1), const Color(0xFF14B8A6),
    ];

    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Elige un color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 14, runSpacing: 14,
              children: colors.map((c) {
                final isSelected = c.value == current.value;
                return GestureDetector(
                  onTap: () { ref.read(primaryColorProvider.notifier).state = c; Navigator.pop(context); },
                  child: Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      color: c, shape: BoxShape.circle,
                      border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 3),
                      boxShadow: [BoxShadow(color: c.withAlpha(102), blurRadius: 8)]),
                    child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends ConsumerWidget {
  final Locale current;
  const _LanguageTile({required this.current});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = AppConstants.languageNames[current.languageCode] ?? 'Español';
    final flag = AppConstants.languageFlags[current.languageCode] ?? '🇪🇸';
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('Idioma'),
      subtitle: Text('$flag $name'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showLanguagePicker(context, ref),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        children: AppConstants.languageNames.entries.map((e) {
          final flag = AppConstants.languageFlags[e.key] ?? '';
          final isSelected = e.key == current.languageCode;
          return ListTile(
            leading: Text(flag, style: const TextStyle(fontSize: 24)),
            title: Text(e.value),
            trailing: isSelected ? const Icon(Icons.check) : null,
            onTap: () { ref.read(localeProvider.notifier).state = Locale(e.key); Navigator.pop(context); },
          );
        }).toList(),
      ),
    );
  }
}

class _AudioQualityTile extends StatelessWidget {
  const _AudioQualityTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.high_quality),
      title: const Text('Calidad de audio'),
      subtitle: const Text('Alta (256 kbps)'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _StorageTile extends StatelessWidget {
  const _StorageTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.storage_outlined),
      title: const Text('Almacenamiento'),
      subtitle: const Text('0 MB usado'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _PrivacyPolicyTile extends StatelessWidget {
  const _PrivacyPolicyTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListTile(
      leading: const Icon(Icons.privacy_tip_outlined),
      title: Text(l10n.t('privacy_policy')),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showPrivacy(context),
    );
  }

  void _showPrivacy(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Política de Privacidad'),
        content: const SingleChildScrollView(
          child: Text(
            'BaiMai Music respeta tu privacidad.\n\n'
            '• No recopilamos datos personales\n'
            '• No requerimos registro\n'
            '• Almacenamiento local\n'
            '• Sin anuncios ni rastreadores\n'
            '• Código abierto y auditable\n\n'
            'Tu privacidad es nuestra prioridad.',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ],
      ),
    );
  }
}

class _SourceCodeTile extends StatelessWidget {
  const _SourceCodeTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.code),
      title: const Text('Código Fuente'),
      subtitle: const Text('GitHub'),
      trailing: const Icon(Icons.open_in_new),
      onTap: () async {
        final uri = Uri.parse(AppConstants.githubUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}

class _AboutTile extends StatelessWidget {
  const _AboutTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('Acerca de'),
      subtitle: Text('${AppConstants.appName} v${AppConstants.appVersion}'),
      onTap: () {
        showAboutDialog(
          context: context,
          applicationName: AppConstants.appName,
          applicationVersion: 'v${AppConstants.appVersion}',
          applicationIcon: const Icon(Icons.music_note, size: 48, color: Colors.purple),
          children: [
            const SizedBox(height: 16),
            Text(AppConstants.tagline, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text('© 2026 ${AppConstants.organization}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        );
      },
    );
  }
}
