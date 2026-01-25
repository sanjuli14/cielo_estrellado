
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

    // ================= ORION =================
    Constellation(
      id: 'orion',
      name: 'Orión',
      description: 'El Cazador. Una de las constelaciones más reconocibles.',
      starsRequired: 50000,
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

    // ================= CRUX =================
    Constellation(
      id: 'crux',
      name: 'Cruz del Sur',
      description: 'Constelación emblemática del hemisferio sur.',
      starsRequired: 5000,
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
      starsRequired: 10000,
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

    // ================= CASSIOPEIA =================
    Constellation(
      id: 'cassiopeia',
      name: 'Casiopea',
      description: 'La Reina. Forma de W.',
      starsRequired: 70000,
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

    // ================= URSA MAJOR =================
    Constellation(
      id: 'ursa_major',
      name: 'Osa Mayor',
      description: 'El Gran Carro.',
      starsRequired: 100000,
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
