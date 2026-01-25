
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
        ConstellationPoint(0.47, 0.46),
        ConstellationPoint(0.53, 0.46),
        ConstellationPoint(0.49, 0.50),
        ConstellationPoint(0.50, 0.51),
        ConstellationPoint(0.51, 0.52),
        ConstellationPoint(0.48, 0.56),
        ConstellationPoint(0.52, 0.55),
      ],
      lines: [
        ConstellationLine(0,2),
        ConstellationLine(1,4),
        ConstellationLine(2,3),
        ConstellationLine(3,4),
        ConstellationLine(2,5),
        ConstellationLine(4,6),
        ConstellationLine(0,1),
        ConstellationLine(5,6),
      ],
    ),

    // ================= CRUX =================
    Constellation(
      id: 'crux',
      name: 'Cruz del Sur',
      description: 'Constelación emblemática del hemisferio sur.',
      starsRequired: 5000,
      points: [
        ConstellationPoint(0.50, 0.44),
        ConstellationPoint(0.50, 0.48),
        ConstellationPoint(0.50, 0.54),
        ConstellationPoint(0.47, 0.50),
        ConstellationPoint(0.53, 0.50),
      ],
      lines: [
        ConstellationLine(0,1),
        ConstellationLine(1,2),
        ConstellationLine(3,1),
        ConstellationLine(1,4),
      ],
    ),

    // ================= SCORPIUS =================
    Constellation(
      id: 'scorpius',
      name: 'Escorpión',
      description: 'Constelación con forma de gancho.',
      starsRequired: 10000,
      points: [
        ConstellationPoint(0.51, 0.43),
        ConstellationPoint(0.49, 0.46),
        ConstellationPoint(0.48, 0.49),
        ConstellationPoint(0.49, 0.52),
        ConstellationPoint(0.52, 0.55),
        ConstellationPoint(0.56, 0.58),
        ConstellationPoint(0.60, 0.61),
      ],
      lines: [
        ConstellationLine(0,1),
        ConstellationLine(1,2),
        ConstellationLine(2,3),
        ConstellationLine(3,4),
        ConstellationLine(4,5),
        ConstellationLine(5,6),
      ],
    ),

    // ================= CASSIOPEIA =================
    Constellation(
      id: 'cassiopeia',
      name: 'Casiopea',
      description: 'La Reina. Forma de W.',
      starsRequired: 70000,
      points: [
        ConstellationPoint(0.47, 0.46),
        ConstellationPoint(0.49, 0.44),
        ConstellationPoint(0.51, 0.46),
        ConstellationPoint(0.53, 0.44),
        ConstellationPoint(0.55, 0.46),
      ],
      lines: [
        ConstellationLine(0,1),
        ConstellationLine(1,2),
        ConstellationLine(2,3),
        ConstellationLine(3,4),
      ],
    ),

    // ================= URSA MAJOR =================
    Constellation(
      id: 'ursa_major',
      name: 'Osa Mayor',
      description: 'El Gran Carro.',
      starsRequired: 100000,
      points: [
        ConstellationPoint(0.47, 0.45),
        ConstellationPoint(0.49, 0.46),
        ConstellationPoint(0.50, 0.48),
        ConstellationPoint(0.48, 0.48),
        ConstellationPoint(0.46, 0.49),
        ConstellationPoint(0.44, 0.50),
        ConstellationPoint(0.42, 0.52),
      ],
      lines: [
        ConstellationLine(0,1),
        ConstellationLine(1,2),
        ConstellationLine(2,3),
        ConstellationLine(3,0),
        ConstellationLine(3,4),
        ConstellationLine(4,5),
        ConstellationLine(5,6),
      ],
    ),
  ];

}
