class MoonPhaseCalculator {
  // Length of a lunar month in days
  static const double synodicMonth = 29.53058867;

  // Known new moon date (January 6, 2000 at 18:14 UTC)
  // We use this as an anchor to calculate phases.
  static final DateTime _knownNewMoon = DateTime.utc(2000, 1, 6, 18, 14, 0);

  /// Returns a value between 0.0 and 1.0 representing the moon's age
  /// 0.0 = New Moon
  /// 0.5 = Full Moon
  /// 1.0 = New Moon (cycle complete)
  static double getMoonPhase(DateTime date) {
    // Calculate difference in milliseconds
    final diff = date.difference(_knownNewMoon).inMilliseconds;
    
    // Convert to days
    final days = diff / Duration.millisecondsPerDay;

    // Calculate phase (0.0 to 1.0)
    final phase = (days % synodicMonth) / synodicMonth;
    
    // Ensure positive result (dart's % can be negative)
    return phase < 0 ? phase + 1 : phase;
  }
}
