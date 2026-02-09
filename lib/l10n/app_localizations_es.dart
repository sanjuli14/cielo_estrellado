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
  String get homeReminderTitle => '¡Mantén tu racha de estrellas!';

  @override
  String get homeReminderBody =>
      'Entra hoy para no perder tus días seguidos de enfoque.';

  @override
  String homeReminderSet(Object time) {
    return 'Recordatorio de racha programado a las $time';
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

  @override
  String get onboardingWelcomeTitle => 'Bienvenido a Focus Night';

  @override
  String get onboardingWelcomeDesc =>
      'Convierte tu tiempo de enfoque en un hermoso cielo estrellado lleno de constelaciones';

  @override
  String get onboardingStarsTitle => 'Genera Estrellas';

  @override
  String get onboardingStarsDesc =>
      'Cada segundo de enfoque genera 3 estrellas. Trabaja concentrado y llena tu cielo nocturno';

  @override
  String get onboardingConstellationsTitle => 'Desbloquea Constelaciones';

  @override
  String get onboardingConstellationsDesc =>
      'Acumula estrellas para descubrir 13 hermosas constelaciones. Desde Corona Boreal hasta la Osa Mayor';

  @override
  String get onboardingGoalsTitle => 'Define tus Metas';

  @override
  String get onboardingGoalsDesc =>
      'Establece objetivos mensuales de estrellas y mantén rachas de días consecutivos trabajando';

  @override
  String get onboardingDistractionsTitle => 'Elimina Distracciones';

  @override
  String get onboardingDistractionsDesc =>
      'Bloquea aplicaciones que te distraen durante tus sesiones de enfoque profundo';

  @override
  String get onboardingProgressTitle => 'Analiza tu Progreso';

  @override
  String get onboardingProgressDesc =>
      'Revisa gráficos detallados de tu productividad semanal y mensual. Mejora continuamente';

  @override
  String get onboardingSkip => 'Saltar';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingStart => 'Comenzar';

  @override
  String get splashCopyright =>
      'Copyright (c) 2026. Todos los derechos reservados';

  @override
  String get blockerTitle => 'Bloqueo de Apps';

  @override
  String get blockerUsageTitle => '1. Acceso de Uso';

  @override
  String get blockerUsageDesc =>
      'Necesitamos saber qué app estás usando actualmente.\n\nBusca \"Cielo Estrellado\" en la lista y activa \"Permitir acceso a uso\".';

  @override
  String get blockerUsageBtn => 'Ir a Acceso de Uso';

  @override
  String get blockerOverlayTitle => '2. Aparecer Encima';

  @override
  String get blockerOverlayDesc =>
      'Necesitamos bloquear la pantalla cuando abras una app prohibida.\n\nBusca \"Cielo Estrellado\" y activa \"Permitir mostrar sobre otras apps\".';

  @override
  String get blockerOverlayBtn => 'Ir a Permiso de Superposición';

  @override
  String get constName_corona_borealis => 'Corona Boreal';

  @override
  String get constDesc_corona_borealis =>
      'Una pequeña y hermosa corona de estrellas.';

  @override
  String get constName_aries => 'Aries';

  @override
  String get constDesc_aries =>
      'El Carnero. Una constelación pequeña pero valiente.';

  @override
  String get constName_crux => 'Cruz del Sur';

  @override
  String get constDesc_crux => 'Constelación emblemática del hemisferio sur.';

  @override
  String get constName_scorpius => 'Escorpión';

  @override
  String get constDesc_scorpius => 'Constelación con forma de gancho.';

  @override
  String get constName_cygnus => 'Cisne';

  @override
  String get constDesc_cygnus => 'Conocida también como la Cruz del Norte.';

  @override
  String get constName_draco => 'Draco';

  @override
  String get constDesc_draco => 'El Dragón que serpentea entre las osas.';

  @override
  String get constName_lyra => 'Lira';

  @override
  String get constDesc_lyra =>
      'Contiene a Vega, una de las estrellas más brillantes.';

  @override
  String get constName_pegasus => 'Pegaso';

  @override
  String get constDesc_pegasus => 'El Gran Cuadrado del caballo alado.';

  @override
  String get constName_leo => 'León';

  @override
  String get constDesc_leo =>
      'Una de las constelaciones más antiguas del zodíaco.';

  @override
  String get constName_andromeda => 'Andrómeda';

  @override
  String get constDesc_andromeda =>
      'Encadenada a Pegaso, contiene la galaxia vecina.';

  @override
  String get constName_orion => 'Orión';

  @override
  String get constDesc_orion =>
      'El Cazador. Una de las constelaciones más reconocibles.';

  @override
  String get constName_cassiopeia => 'Casiopea';

  @override
  String get constDesc_cassiopeia => 'La Reina. Forma de W.';

  @override
  String get constName_centaurus => 'Centauro';

  @override
  String get constDesc_centaurus =>
      'Una de las constelaciones más grandes y brillantes.';

  @override
  String get constName_ursa_major => 'Osa Mayor';

  @override
  String get constDesc_ursa_major => 'El Gran Carro.';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsSound => 'Sonido';

  @override
  String get settingsMuted => 'Silenciado';

  @override
  String get settingsActive => 'Activado';

  @override
  String get settingsStats => 'Estadísticas';

  @override
  String get settingsStatsDesc => 'Estadísticas Mensuales';

  @override
  String get settingsNotifs => 'Notificaciones';

  @override
  String get settingsNotifsDesc => 'Configurar recordatorios diarios';

  @override
  String get settingsGoals => 'Metas Personales';

  @override
  String get settingsGoalsDesc => 'Configura tus objetivos';

  @override
  String get settingsBlocker => 'Bloqueo de Apps';

  @override
  String get settingsBlockerDesc => 'Selecciona apps para bloquear';

  @override
  String get statsCatalog => 'Catálogo de Constelaciones';

  @override
  String get statsUnlocked => '¡Desbloqueada!';

  @override
  String statsStarsRequired(Object count) {
    return 'Requiere $count estrellas';
  }

  @override
  String get goalsTitle => 'Metas Personales';

  @override
  String get goalsYourProgress => 'Tu Progreso';

  @override
  String get goalsDefineObjectives => 'Define tus objetivos de productividad';

  @override
  String get goalsSaveBtn => 'Guardar Metas';

  @override
  String get goalsSavedSuccess => 'Metas guardadas exitosamente';

  @override
  String get goalsItemStars => '⭐ Estrellas por mes';

  @override
  String get goalsItemStreak => '🔥 Días seguidos';

  @override
  String get goalsHintStars => 'Ej: 100';

  @override
  String get goalsUnitStars => 'estrellas';

  @override
  String get goalsUnitDays => 'días';

  @override
  String goalsCurrentStreak(Object count) {
    return 'Racha actual: $count días';
  }

  @override
  String goalsProgressStars(Object current, Object target) {
    return '$current - $target estrellas';
  }

  @override
  String get moonNew => 'Luna Nueva';

  @override
  String get moonWaxingCrescent => 'Luna Creciente';

  @override
  String get moonFirstQuarter => 'Cuarto Creciente';

  @override
  String get moonWaxingGibbous => 'Gibosa Creciente';

  @override
  String get moonFull => 'Luna Llena';

  @override
  String get moonWaningGibbous => 'Gibosa Menguante';

  @override
  String get moonLastQuarter => 'Cuarto Menguante';

  @override
  String get moonWaningCrescent => 'Luna Menguante';

  @override
  String get rankStardust => 'Polvo Estelar';

  @override
  String get rankFlicker => 'Destello Errante';

  @override
  String get rankObserver => 'Observador Estelar';

  @override
  String get rankGuardian => 'Guardián del Vacío';

  @override
  String get rankHunter => 'Cazador de Nebulosas';

  @override
  String get rankVoyager => 'Viajero Intergaláctico';

  @override
  String get rankMaster => 'Maestro de Constelaciones';

  @override
  String get rankArchitect => 'Arquitecto del Cosmos';

  @override
  String get missionTitle => 'Misiones';

  @override
  String get missionDaily => 'Diarias';

  @override
  String get missionWeekly => 'Semanales';

  @override
  String get missionMilestones => 'Hitos';

  @override
  String get missionFocus1 => 'Primer Enfoque';

  @override
  String get missionFocus1Desc => 'Completa 1 sesión de al menos 20 minutos.';

  @override
  String get missionStars500 => 'Cosecha Estelar';

  @override
  String get missionStars500Desc => 'Consigue 500 estrellas en un día.';
}
