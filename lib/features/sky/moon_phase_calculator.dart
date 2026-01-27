enum MoonPhase {
  newMoon,
  waxingCrescent,
  firstQuarter,
  waxingGibbous,
  fullMoon,
  waningGibbous,
  lastQuarter,
  waningCrescent,
}

class MoonPhaseCalculator {
  static const double synodicMonth = 29.530588853;

  // Luna nueva real: 2000-01-06 18:14 UTC
  static final DateTime _knownNewMoon = DateTime.utc(2000, 1, 6, 18, 14);

  /// Retorna fase entre 0.0 y 1.0
  /// 0.0 = Luna Nueva
  /// 0.25 = Cuarto Creciente
  /// 0.5 = Luna Llena
  /// 0.75 = Cuarto Menguante
  static double getMoonPhase(DateTime date) {
    // Convertimos SIEMPRE a UTC
    final utcDate = date.toUtc();

    final diff = utcDate.difference(_knownNewMoon).inMicroseconds;

    final days = diff / Duration.microsecondsPerDay;

    final phase = (days % synodicMonth) / synodicMonth;

    return phase < 0 ? phase + 1 : phase;
  }

  static MoonPhase getPhaseName(double phase) {
    if (phase < 0.03 || phase > 0.97) return MoonPhase.newMoon;
    if (phase < 0.22) return MoonPhase.waxingCrescent;
    if (phase < 0.28) return MoonPhase.firstQuarter;
    if (phase < 0.47) return MoonPhase.waxingGibbous;
    if (phase < 0.53) return MoonPhase.fullMoon;
    if (phase < 0.72) return MoonPhase.waningGibbous;
    if (phase < 0.78) return MoonPhase.lastQuarter;
    return MoonPhase.waningCrescent;
  }

  static String getMoonPhaseLabel(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.newMoon:
        return 'Luna Nueva';
      case MoonPhase.waxingCrescent:
        return 'Luna Creciente';
      case MoonPhase.firstQuarter:
        return 'Cuarto Creciente';
      case MoonPhase.waxingGibbous:
        return 'Gibosa Creciente';
      case MoonPhase.fullMoon:
        return 'Luna Llena';
      case MoonPhase.waningGibbous:
        return 'Gibosa Menguante';
      case MoonPhase.lastQuarter:
        return 'Cuarto Menguante';
      case MoonPhase.waningCrescent:
        return 'Luna Menguante';
    }
  }
}
