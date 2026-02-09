
import 'package:cielo_estrellado/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ConstellationPoint {
  final double x; // Normalized 0.0 to 1.0 (left to right)
  final double y; // Normalized 0.0 to 1.0 (top to bottom)

  const ConstellationPoint(this.x, this.y);
}

class ConstellationLine {
  final int startIndex;
  final int endIndex;

  const ConstellationLine(this.startIndex, this.endIndex);
}

class Constellation {
  final String id;
  final String name;
  final String description;
  final int starsRequired;
  final List<ConstellationPoint> points;
  final List<ConstellationLine> lines;

  const Constellation({
    required this.id,
    required this.name,
    required this.description,
    required this.starsRequired,
    required this.points,
    required this.lines,
  });

  // Static list used for non-UI logic (e.g. providers)
  static List<Constellation> get all => [
    _dummy('corona_borealis', 5000, [
        const ConstellationPoint(0.40, 0.15),
        const ConstellationPoint(0.37, 0.17),
        const ConstellationPoint(0.36, 0.20),
        const ConstellationPoint(0.37, 0.23),
        const ConstellationPoint(0.40, 0.25),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
      ]),
    _dummy('aries', 12000, [
        const ConstellationPoint(0.12, 0.48),
        const ConstellationPoint(0.16, 0.46),
        const ConstellationPoint(0.20, 0.49),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
      ]),
    _dummy('crux', 20000, [
        const ConstellationPoint(0.15, 0.15),
        const ConstellationPoint(0.15, 0.18),
        const ConstellationPoint(0.15, 0.23),
        const ConstellationPoint(0.13, 0.18),
        const ConstellationPoint(0.17, 0.18),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(3, 1),
        const ConstellationLine(1, 4),
      ]),
    _dummy('scorpius', 50000, [
        const ConstellationPoint(0.85, 0.65),
        const ConstellationPoint(0.84, 0.67),
        const ConstellationPoint(0.83, 0.69),
        const ConstellationPoint(0.84, 0.72),
        const ConstellationPoint(0.86, 0.74),
        const ConstellationPoint(0.88, 0.75),
        const ConstellationPoint(0.90, 0.74),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
        const ConstellationLine(4, 5),
        const ConstellationLine(5, 6),
      ]),
    _dummy('cygnus', 100000, [
        const ConstellationPoint(0.45, 0.45),
        const ConstellationPoint(0.45, 0.55),
        const ConstellationPoint(0.45, 0.65),
        const ConstellationPoint(0.35, 0.55),
        const ConstellationPoint(0.55, 0.55),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(1, 3),
        const ConstellationLine(1, 4),
      ]),
    _dummy('draco', 150000, [
        const ConstellationPoint(0.58, 0.25),
        const ConstellationPoint(0.64, 0.20),
        const ConstellationPoint(0.72, 0.24),
        const ConstellationPoint(0.68, 0.30),
        const ConstellationPoint(0.62, 0.34),
        const ConstellationPoint(0.58, 0.40),
        const ConstellationPoint(0.56, 0.46),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
        const ConstellationLine(4, 5),
        const ConstellationLine(5, 6),
      ]),
    _dummy('lyra', 200000, [
        const ConstellationPoint(0.25, 0.35),
        const ConstellationPoint(0.27, 0.38),
        const ConstellationPoint(0.26, 0.41),
        const ConstellationPoint(0.24, 0.41),
        const ConstellationPoint(0.23, 0.38),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
        const ConstellationLine(4, 1),
      ]),
    _dummy('pegasus', 300000, [
        const ConstellationPoint(0.08, 0.32),
        const ConstellationPoint(0.18, 0.32),
        const ConstellationPoint(0.18, 0.42),
        const ConstellationPoint(0.08, 0.42),
        const ConstellationPoint(0.05, 0.28),
        const ConstellationPoint(0.02, 0.35),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 0),
        const ConstellationLine(0, 4),
        const ConstellationLine(3, 5),
      ]),
    _dummy('leo', 400000, [
        const ConstellationPoint(0.75, 0.75),
        const ConstellationPoint(0.78, 0.72),
        const ConstellationPoint(0.82, 0.73),
        const ConstellationPoint(0.84, 0.77),
        const ConstellationPoint(0.82, 0.81),
        const ConstellationPoint(0.72, 0.82),
        const ConstellationPoint(0.68, 0.80),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
        const ConstellationLine(4, 0),
        const ConstellationLine(0, 5),
        const ConstellationLine(5, 6),
      ]),
    _dummy('andromeda', 550000, [
        const ConstellationPoint(0.18, 0.32),
        const ConstellationPoint(0.24, 0.28),
        const ConstellationPoint(0.30, 0.26),
        const ConstellationPoint(0.26, 0.22),
        const ConstellationPoint(0.32, 0.18),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
      ]),
    _dummy('orion', 750000, [
        const ConstellationPoint(0.25, 0.60),
        const ConstellationPoint(0.29, 0.60),
        const ConstellationPoint(0.26, 0.64),
        const ConstellationPoint(0.27, 0.645),
        const ConstellationPoint(0.28, 0.65),
        const ConstellationPoint(0.26, 0.68),
        const ConstellationPoint(0.28, 0.68),
      ], [
        const ConstellationLine(0, 2),
        const ConstellationLine(1, 4),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
        const ConstellationLine(2, 5),
        const ConstellationLine(4, 6),
        const ConstellationLine(0, 1),
        const ConstellationLine(5, 6),
      ]),
    _dummy('cassiopeia', 1200000, [
        const ConstellationPoint(0.75, 0.22),
        const ConstellationPoint(0.77, 0.19),
        const ConstellationPoint(0.79, 0.22),
        const ConstellationPoint(0.81, 0.19),
        const ConstellationPoint(0.83, 0.22),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
      ]),
    _dummy('centaurus', 1800000, [
        const ConstellationPoint(0.45, 0.85),
        const ConstellationPoint(0.50, 0.80),
        const ConstellationPoint(0.55, 0.82),
        const ConstellationPoint(0.60, 0.88),
        const ConstellationPoint(0.55, 0.94),
        const ConstellationPoint(0.50, 0.92),
        const ConstellationPoint(0.48, 0.88),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 4),
        const ConstellationLine(4, 5),
        const ConstellationLine(5, 6),
        const ConstellationLine(6, 0),
      ]),
    _dummy('ursa_major', 2500000, [
        const ConstellationPoint(0.50, 0.30),
        const ConstellationPoint(0.54, 0.31),
        const ConstellationPoint(0.55, 0.35),
        const ConstellationPoint(0.51, 0.345),
        const ConstellationPoint(0.47, 0.36),
        const ConstellationPoint(0.44, 0.37),
        const ConstellationPoint(0.41, 0.39),
      ], [
        const ConstellationLine(0, 1),
        const ConstellationLine(1, 2),
        const ConstellationLine(2, 3),
        const ConstellationLine(3, 0),
        const ConstellationLine(3, 4),
        const ConstellationLine(4, 5),
        const ConstellationLine(5, 6),
      ]),
  ];

  static Constellation _dummy(String id, int stars, List<ConstellationPoint> pts, List<ConstellationLine> lines) {
    return Constellation(
      id: id,
      name: id,
      description: '',
      starsRequired: stars,
      points: pts,
      lines: lines,
    );
  }

  // Static method to get all constellations with localized strings
  static List<Constellation> getAll(AppLocalizations l10n) => [
    // ================= CORONA BOREALIS =================
    Constellation(
      id: 'corona_borealis',
      name: l10n.constName_corona_borealis,
      description: l10n.constDesc_corona_borealis,
      starsRequired: 5000,
      points: [
        ConstellationPoint(0.40, 0.15),
        ConstellationPoint(0.37, 0.17),
        ConstellationPoint(0.36, 0.20),
        ConstellationPoint(0.37, 0.23),
        ConstellationPoint(0.40, 0.25),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
      ],
    ),

    // ================= ARIES =================
    Constellation(
      id: 'aries',
      name: l10n.constName_aries,
      description: l10n.constDesc_aries,
      starsRequired: 12000,
      points: [
        ConstellationPoint(0.12, 0.48),
        ConstellationPoint(0.16, 0.46),
        ConstellationPoint(0.20, 0.49),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
      ],
    ),

    // ================= CRUX =================
    Constellation(
      id: 'crux',
      name: l10n.constName_crux,
      description: l10n.constDesc_crux,
      starsRequired: 20000,
      points: [
        ConstellationPoint(0.15, 0.15), // Top
        ConstellationPoint(0.15, 0.18), // Center
        ConstellationPoint(0.15, 0.23), // Bottom
        ConstellationPoint(0.13, 0.18), // Left
        ConstellationPoint(0.17, 0.18), // Right
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(3, 1),
        ConstellationLine(1, 4),
      ],
    ),

    // ================= SCORPIUS =================
    Constellation(
      id: 'scorpius',
      name: l10n.constName_scorpius,
      description: l10n.constDesc_scorpius,
      starsRequired: 50000,
      points: [
        ConstellationPoint(0.85, 0.65),
        ConstellationPoint(0.84, 0.67),
        ConstellationPoint(0.83, 0.69),
        ConstellationPoint(0.84, 0.72),
        ConstellationPoint(0.86, 0.74),
        ConstellationPoint(0.88, 0.75),
        ConstellationPoint(0.90, 0.74),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
        ConstellationLine(4, 5),
        ConstellationLine(5, 6),
      ],
    ),

    // ================= CYGNUS =================
    Constellation(
      id: 'cygnus',
      name: l10n.constName_cygnus,
      description: l10n.constDesc_cygnus,
      starsRequired: 100000,
      points: [
        ConstellationPoint(0.45, 0.45), // Deneb
        ConstellationPoint(0.45, 0.55), // Center
        ConstellationPoint(0.45, 0.65), // Albireo
        ConstellationPoint(0.35, 0.55), // Wing L
        ConstellationPoint(0.55, 0.55), // Wing R
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(1, 3),
        ConstellationLine(1, 4),
      ],
    ),

    // ================= DRACO =================
    Constellation(
      id: 'draco',
      name: l10n.constName_draco,
      description: l10n.constDesc_draco,
      starsRequired: 150000,
      points: [
        ConstellationPoint(0.58, 0.25),
        ConstellationPoint(0.64, 0.20),
        ConstellationPoint(0.72, 0.24),
        ConstellationPoint(0.68, 0.30),
        ConstellationPoint(0.62, 0.34),
        ConstellationPoint(0.58, 0.40),
        ConstellationPoint(0.56, 0.46),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
        ConstellationLine(4, 5),
        ConstellationLine(5, 6),
      ],
    ),

    // ================= LYRA =================
    Constellation(
      id: 'lyra',
      name: l10n.constName_lyra,
      description: l10n.constDesc_lyra,
      starsRequired: 200000,
      points: [
        ConstellationPoint(0.25, 0.35), // Vega
        ConstellationPoint(0.27, 0.38),
        ConstellationPoint(0.26, 0.41),
        ConstellationPoint(0.24, 0.41),
        ConstellationPoint(0.23, 0.38),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
        ConstellationLine(4, 1),
      ],
    ),

    // ================= PEGASUS =================
    Constellation(
      id: 'pegasus',
      name: l10n.constName_pegasus,
      description: l10n.constDesc_pegasus,
      starsRequired: 300000,
      points: [
        ConstellationPoint(0.08, 0.32),
        ConstellationPoint(0.18, 0.32),
        ConstellationPoint(0.18, 0.42),
        ConstellationPoint(0.08, 0.42),
        ConstellationPoint(0.05, 0.28),
        ConstellationPoint(0.02, 0.35),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 0),
        ConstellationLine(0, 4),
        ConstellationLine(3, 5),
      ],
    ),

    // ================= LEO =================
    Constellation(
      id: 'leo',
      name: l10n.constName_leo,
      description: l10n.constDesc_leo,
      starsRequired: 400000,
      points: [
        ConstellationPoint(0.75, 0.75),
        ConstellationPoint(0.78, 0.72),
        ConstellationPoint(0.82, 0.73),
        ConstellationPoint(0.84, 0.77),
        ConstellationPoint(0.82, 0.81),
        ConstellationPoint(0.72, 0.82),
        ConstellationPoint(0.68, 0.80),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
        ConstellationLine(4, 0),
        ConstellationLine(0, 5),
        ConstellationLine(5, 6),
      ],
    ),

    // ================= ANDROMEDA =================
    Constellation(
      id: 'andromeda',
      name: l10n.constName_andromeda,
      description: l10n.constDesc_andromeda,
      starsRequired: 550000,
      points: [
        ConstellationPoint(0.18, 0.32),
        ConstellationPoint(0.24, 0.28),
        ConstellationPoint(0.30, 0.26),
        ConstellationPoint(0.26, 0.22),
        ConstellationPoint(0.32, 0.18),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
      ],
    ),

    // ================= ORION =================
    Constellation(
      id: 'orion',
      name: l10n.constName_orion,
      description: l10n.constDesc_orion,
      starsRequired: 750000,
      points: [
        ConstellationPoint(0.25, 0.60), // Shoulder L
        ConstellationPoint(0.29, 0.60), // Shoulder R
        ConstellationPoint(0.26, 0.64), // Belt 1
        ConstellationPoint(0.27, 0.645), // Belt 2
        ConstellationPoint(0.28, 0.65), // Belt 3
        ConstellationPoint(0.26, 0.68), // Foot L
        ConstellationPoint(0.28, 0.68), // Foot R
      ],
      lines: [
        ConstellationLine(0, 2),
        ConstellationLine(1, 4),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
        ConstellationLine(2, 5),
        ConstellationLine(4, 6),
        ConstellationLine(0, 1),
        ConstellationLine(5, 6),
      ],
    ),

    // ================= CASSIOPEIA =================
    Constellation(
      id: 'cassiopeia',
      name: l10n.constName_cassiopeia,
      description: l10n.constDesc_cassiopeia,
      starsRequired: 1200000,
      points: [
        ConstellationPoint(0.75, 0.22),
        ConstellationPoint(0.77, 0.19),
        ConstellationPoint(0.79, 0.22),
        ConstellationPoint(0.81, 0.19),
        ConstellationPoint(0.83, 0.22),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
      ],
    ),

    // ================= CENTAURUS =================
    Constellation(
      id: 'centaurus',
      name: l10n.constName_centaurus,
      description: l10n.constDesc_centaurus,
      starsRequired: 1800000,
      points: [
        ConstellationPoint(0.45, 0.85),
        ConstellationPoint(0.50, 0.80),
        ConstellationPoint(0.55, 0.82),
        ConstellationPoint(0.60, 0.88),
        ConstellationPoint(0.55, 0.94),
        ConstellationPoint(0.50, 0.92),
        ConstellationPoint(0.48, 0.88),
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
        ConstellationLine(4, 5),
        ConstellationLine(5, 6),
        ConstellationLine(6, 0),
      ],
    ),

    // ================= URSA MAJOR =================
    Constellation(
      id: 'ursa_major',
      name: l10n.constName_ursa_major,
      description: l10n.constDesc_ursa_major,
      starsRequired: 2500000,
      points: [
        ConstellationPoint(0.50, 0.30), // Bucket Top L
        ConstellationPoint(0.54, 0.31), // Bucket Top R
        ConstellationPoint(0.55, 0.35), // Bucket Bot R
        ConstellationPoint(0.51, 0.345), // Bucket Bot L
        ConstellationPoint(0.47, 0.36), // Handle 1
        ConstellationPoint(0.44, 0.37), // Handle 2
        ConstellationPoint(0.41, 0.39), // Handle 3
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 0),
        ConstellationLine(3, 4),
        ConstellationLine(4, 5),
        ConstellationLine(5, 6),
      ],
    ),
  ];
}
