
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

  // Static list of constellations
  static const List<Constellation> all = [
    // ================= CORONA BOREALIS =================
    Constellation(
      id: 'corona_borealis',
      name: 'Corona Boreal',
      description: 'Una pequeña y hermosa corona de estrellas.',
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
      name: 'Aries',
      description: 'El Carnero. Una constelación pequeña pero valiente.',
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
      name: 'Cruz del Sur',
      description: 'Constelación emblemática del hemisferio sur.',
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
      name: 'Escorpión',
      description: 'Constelación con forma de gancho.',
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
      name: 'Cisne',
      description: 'Conocida también como la Cruz del Norte.',
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
      name: 'Draco',
      description: 'El Dragón que serpentea entre las osas.',
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
      name: 'Lira',
      description: 'Contiene a Vega, una de las estrellas más brillantes.',
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
      name: 'Pegaso',
      description: 'El Gran Cuadrado del caballo alado.',
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
      name: 'León',
      description: 'Una de las constelaciones más antiguas del zodíaco.',
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
      name: 'Andrómeda',
      description: 'Encadenada a Pegaso, contiene la galaxia vecina.',
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
      name: 'Orión',
      description: 'El Cazador. Una de las constelaciones más reconocibles.',
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
      name: 'Casiopea',
      description: 'La Reina. Forma de W.',
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
      name: 'Centauro',
      description: 'Una de las constelaciones más grandes y brillantes.',
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
      name: 'Osa Mayor',
      description: 'El Gran Carro.',
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
