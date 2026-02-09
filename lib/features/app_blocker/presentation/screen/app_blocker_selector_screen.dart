import 'package:cielo_estrellado/features/app_blocker/presentation/controller/app_blocker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cielo_estrellado/l10n/app_localizations.dart';

class AppBlockerSelectorScreen extends ConsumerStatefulWidget {
  const AppBlockerSelectorScreen({super.key});

  @override
  ConsumerState<AppBlockerSelectorScreen> createState() => _AppBlockerSelectorScreenState();
}

class _AppBlockerSelectorScreenState extends ConsumerState<AppBlockerSelectorScreen> with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-check permissions when coming back from settings
     ref.read(appBlockerControllerProvider.notifier).checkPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appBlockerControllerProvider);
    final theme = Theme.of(context);

    // Permission Check Logic
    if (!state.hasUsagePermission) {
      return _buildPermissionRequest(
        context,
        icon: Icons.data_usage,
        title: AppLocalizations.of(context)!.blockerUsageTitle,
        description: AppLocalizations.of(context)!.blockerUsageDesc,
        buttonText: AppLocalizations.of(context)!.blockerUsageBtn,
        onPressed: () => ref.read(appBlockerControllerProvider.notifier).requestUsagePermission(),
      );
    }
    
    if (!state.hasOverlayPermission) {
       return _buildPermissionRequest(
        context,
        icon: Icons.layers,
        title: AppLocalizations.of(context)!.blockerOverlayTitle,
        description: AppLocalizations.of(context)!.blockerOverlayDesc,
        buttonText: AppLocalizations.of(context)!.blockerOverlayBtn,
        onPressed: () => ref.read(appBlockerControllerProvider.notifier).requestOverlayPermission(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.blockerTitle),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
                  itemCount: state.apps.length,
                  itemBuilder: (context, index) {
                    final app = state.apps[index];
                    final packageName = app.packageName ?? '';
                    final isBlocked = state.blockedPackageNames.contains(packageName);

                    return SwitchListTile(
                      value: isBlocked,
                      onChanged: (value) {
                        ref.read(appBlockerControllerProvider.notifier).toggleAppBlock(packageName);
                      },
                      secondary: app.icon != null
                          ? Image.memory(
                              app.icon!,
                              width: 40,
                              height: 40,
                            )
                          : const Icon(Icons.android, size: 40),
                      title: Text(app.name ?? packageName),
                      subtitle: Text(packageName, style: const TextStyle(fontSize: 10)),
                    );
                  },
                ),
    );
  }

  Widget _buildPermissionRequest(BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.blockerTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              Text(title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
