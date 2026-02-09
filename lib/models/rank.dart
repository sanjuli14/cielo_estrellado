import 'package:cielo_estrellado/l10n/app_localizations.dart';

enum Rank {
  stardust,      // 0 - 5,000
  flicker,       // 5,001 - 15,000
  observer,      // 15,001 - 40,000
  guardian,      // 40,001 - 100,000
  hunter,        // 100,001 - 250,000
  voyager,       // 250,001 - 600,000
  master,        // 600,001 - 1,500,000
  architect;     // 1,500,001+

  static Rank fromStars(int stars) {
    if (stars <= 5000) return Rank.stardust;
    if (stars <= 15000) return Rank.flicker;
    if (stars <= 40000) return Rank.observer;
    if (stars <= 100000) return Rank.guardian;
    if (stars <= 250000) return Rank.hunter;
    if (stars <= 600000) return Rank.voyager;
    if (stars <= 1500000) return Rank.master;
    return Rank.architect;
  }

  String getTitle(AppLocalizations l10n) {
    switch (this) {
      case Rank.stardust: return l10n.rankStardust;
      case Rank.flicker: return l10n.rankFlicker;
      case Rank.observer: return l10n.rankObserver;
      case Rank.guardian: return l10n.rankGuardian;
      case Rank.hunter: return l10n.rankHunter;
      case Rank.voyager: return l10n.rankVoyager;
      case Rank.master: return l10n.rankMaster;
      case Rank.architect: return l10n.rankArchitect;
    }
  }

  int getThreshold() {
    switch (this) {
      case Rank.stardust: return 0;
      case Rank.flicker: return 5001;
      case Rank.observer: return 15001;
      case Rank.guardian: return 40001;
      case Rank.hunter: return 100001;
      case Rank.voyager: return 250001;
      case Rank.master: return 600001;
      case Rank.architect: return 1500001;
    }
  }
}
