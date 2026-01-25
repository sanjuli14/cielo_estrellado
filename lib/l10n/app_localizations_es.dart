// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Focus Night';

  @override
  String get splashEveryMinute => 'Cada Minuto Importa';

  @override
  String get splashEveryStar => 'Cada Estrella Cuenta';

  @override
  String get homeActivateFocus => 'Activa tu Enfoque';

  @override
  String homeLastSession(Object duration, Object stars) {
    return 'Última sesión: $duration min — $stars estrellas';
  }

  @override
  String get homeSessionCompleted => '¡Sesión completada!';

  @override
  String homeMinutesFocus(Object minutes) {
    return '$minutes minutos de enfoque';
  }

  @override
  String homeStarsGenerated(Object stars) {
    return '$stars estrellas generadas';
  }

  @override
  String get homeShareText =>
      'El cielo de hoy quedó completo. Compartelo con amigos';

  @override
  String get homeSwipeUpStats => 'Desliza hacia arriba para ver estadisticas';

  @override
  String get homeMuteTooltip => 'Silenciar música';

  @override
  String get homeUnmuteTooltip => 'Activar música';

  @override
  String get homeReminderTooltip => 'Configurar recordatorio diario';

  @override
  String get homeReminderTitle => 'Es hora de ver las estrellas';

  @override
  String get homeReminderBody =>
      'Enfocate mientras trabajas, y genera un cielo brillante';

  @override
  String homeReminderSet(Object time) {
    return 'Recordatorio diario programado a las $time';
  }

  @override
  String get homeReminderDenied => 'Permisos de notificación rechazados';

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get statsDailyHours => 'Horas diarias (últimos 7 días)';

  @override
  String get statsMonthlyStars => 'Estrellas mensuales';

  @override
  String get statsNoData => 'No hay datos disponibles';

  @override
  String statsError(Object error) {
    return 'Error: $error';
  }

  @override
  String get statsUnitMin => 'min';

  @override
  String get statsUnitStars => 'estrellas';

  @override
  String constellationUnlocked(Object stars) {
    return 'Desbloqueada a las $stars estrellas';
  }

  @override
  String get notifChannelName => 'Recordatorios Diarios';

  @override
  String get notifChannelDesc =>
      'Canal para recordatorios de uso de la aplicación';
}
