import 'package:cielo_estrellado/core/audio/audio_provider.dart';
import 'package:cielo_estrellado/core/notifications/notification_service.dart';
import 'package:cielo_estrellado/l10n/app_localizations.dart';
import 'package:cielo_estrellado/presentation/screen/goals/goals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late bool _isMuted;

  @override
  void initState() {
    super.initState();
    _isMuted = ref.read(audioServiceProvider).isMuted;
  }

  void _toggleMute() {
    final audioService = ref.read(audioServiceProvider);
    audioService.toggleMute();
    setState(() {
      _isMuted = audioService.isMuted;
    });
  }

  Future<void> _setupReminder(BuildContext context, WidgetRef ref) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 23, minute: 00),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFFD1A4),
              onPrimary: Colors.black,
              surface: Color(0xFF1A1F3C),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final granted = await NotificationService().requestPermissions();
      if (granted) {
        final box = await Hive.openBox('settings');
        await box.put('notif_hour', picked.hour);
        await box.put('notif_minute', picked.minute);

        final l10n = AppLocalizations.of(context)!;
        await NotificationService().scheduleDailyNotification(
          id: 0,
          title: l10n.homeReminderTitle,
          body: l10n.homeReminderBody,
          time: picked,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.homeReminderSet(picked.format(context)),
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: const Color(0xFFFFD1A4),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.homeReminderDenied),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Configuración',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildSettingCard(
              icon: Icons.volume_up_outlined,
              title: 'Sonido',
              subtitle: _isMuted ? 'Silenciado' : 'Activado',
              onTap: _toggleMute,
              trailing: Switch(
                value: !_isMuted,
                onChanged: (_) => _toggleMute(),
                activeColor: const Color(0xFFFFD1A4),
                activeTrackColor: const Color(0xFFFFD1A4).withOpacity(0.5),
                inactiveThumbColor: Colors.white70,
                inactiveTrackColor: Colors.transparent,
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return null; // Use default for active
                  }
                  return Colors.white24; // Subtle border for inactive
                }),
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              icon: Icons.notifications_active_outlined,
              title: 'Notificaciones',
              subtitle: 'Configurar recordatorios diarios',
              onTap: () => _setupReminder(context, ref),
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              icon: Icons.emoji_events_outlined,
              title: 'Metas Personales',
              subtitle: 'Configura tus objetivos',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const GoalsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD1A4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFFFD1A4),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else
              Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.3),
              ),
          ],
        ),
      ),
    );
  }
}
