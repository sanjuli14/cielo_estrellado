
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
    Constellation(
      id: 'orion',
      name: 'Orión',
      description: 'El Cazador. Una de las constelaciones más reconocibles del cielo nocturno.',
      starsRequired: 500000,
      points: [
          // Betelgeuse (Top Left)
          ConstellationPoint(0.35, 0.40), 
          // Bellatrix (Top Right)
          ConstellationPoint(0.48, 0.38),
          // Mintaka (Belt Left)
          ConstellationPoint(0.40, 0.50),
          // Alnilam (Belt Middle)
          ConstellationPoint(0.43, 0.51),
          // Alnitak (Belt Right)
          ConstellationPoint(0.46, 0.52),
          // Saiph (Bottom Left)
          ConstellationPoint(0.38, 0.65),
          // Rigel (Bottom Right)
          ConstellationPoint(0.50, 0.62),
      ],
      lines: [
          // Shoulders
          ConstellationLine(0, 2), // Betelgeuse -> Belt Left
          ConstellationLine(1, 4), // Bellatrix -> Belt Right
          // Belt
          ConstellationLine(2, 3),
          ConstellationLine(3, 4),
          // Legs
          ConstellationLine(2, 5), // Belt Left -> Saiph
          ConstellationLine(4, 6), // Belt Right -> Rigel
          // Body/Shield? (Simplified)
          ConstellationLine(0, 1),
          ConstellationLine(5, 6),
      ],
    ),
    Constellation(
      id: 'cassiopeia',
      name: 'Casiopea',
      description: 'La Reina. Reconocible por su forma de "W" o "M".',
      starsRequired: 1200000,
      points: [
        ConstellationPoint(0.65, 0.20), // Caph
        ConstellationPoint(0.70, 0.25), // Schedar
        ConstellationPoint(0.73, 0.22), // Gamma Cas
        ConstellationPoint(0.76, 0.28), // Ruchbah
        ConstellationPoint(0.80, 0.23), // Segin
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 4),
      ],
    ),
     Constellation(
      id: 'ursa_major',
      name: 'Osa Mayor',
      description: 'El Gran Carro es parte de esta constelación.',
      starsRequired: 2500000,
      points: [
        ConstellationPoint(0.15, 0.20), // Dubhe
        ConstellationPoint(0.20, 0.22), // Merak
        ConstellationPoint(0.18, 0.28), // Phad
        ConstellationPoint(0.14, 0.27), // Megrez
        ConstellationPoint(0.10, 0.29), // Alioth
        ConstellationPoint(0.06, 0.31), // Mizar
        ConstellationPoint(0.02, 0.35), // Alkaid
      ],
      lines: [
        ConstellationLine(0, 1),
        ConstellationLine(1, 2),
        ConstellationLine(2, 3),
        ConstellationLine(3, 0), // Box
        ConstellationLine(3, 4), // Handle start
        ConstellationLine(4, 5),
        ConstellationLine(5, 6),
      ],
    ),
  ];
}
