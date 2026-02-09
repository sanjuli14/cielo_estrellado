import 'package:cielo_estrellado/models/life_quest.dart';
import 'package:cielo_estrellado/models/quest_level.dart';
import 'package:cielo_estrellado/models/quest_task.dart';

class QuestPool {
  static List<LifeQuest> generateInitialQuests() {
    return [
      _createCaminoMaestro(),
      _createConstanciaEstelar(),
      _createProfundidadVacio(),
    ];
  }

  static LifeQuest _createCaminoMaestro() {
    // A chain of 25 levels
    List<QuestLevel> levels = [];
    for (int i = 1; i <= 125; i++) {
       levels.add(QuestLevel(
         id: 'cm_lvl_$i',
         name: _getLevelName(i),
         xpReward: 500 + (i * 100),
         tasks: [
           QuestTask(
             id: 'cm_task_min_$i',
             description: 'Acumula ${(10 * i)} horas de enfoque',
             xpReward: 250 + (i * 50),
             targetValue: (10.0 * i * 60.0), // minutes
             unit: 'minutos',
           ),
           QuestTask(
             id: 'cm_task_ses_$i',
             description: 'Completa ${(20 * i)} sesiones totales',
             xpReward: 250 + (i * 50),
             targetValue: (20.0 * i),
             unit: 'sesiones',
           ),
         ],
       ));
    }

    return LifeQuest(
      id: 'focus_milestone_1',
      title: 'Camino del Maestro',
      description: 'Tu ascenso hacia la maestría absoluta.',
      category: 'Foco',
      type: 'milestone',
      levels: levels,
    );
  }

  static LifeQuest _createConstanciaEstelar() {
    // Focus on streaks and daily consistency
    List<QuestLevel> levels = [];
    for (int i = 1; i <= 125; i++) {
       levels.add(QuestLevel(
         id: 'ce_lvl_$i',
         name: 'Constancia Nivel $i',
         xpReward: 400 + (i * 80),
         tasks: [
           QuestTask(
             id: 'ce_task_days_$i',
             description: 'Mantén el hábito por ${3 * i} días',
             xpReward: 400 + (i * 80),
             targetValue: (3.0 * i),
             unit: 'días', // We'll need to handle 'days' in processor or just keep it as a metric
           ),
         ],
       ));
    }

    return LifeQuest(
      id: 'focus_milestone_2',
      title: 'Constancia Estelar',
      description: 'Premia tu disciplina inquebrantable.',
      category: 'Foco',
      type: 'milestone',
      levels: levels,
    );
  }

  static LifeQuest _createProfundidadVacio() {
     // Focus on session length
    List<QuestLevel> levels = [];
    for (int i = 1; i <= 125; i++) {
       levels.add(QuestLevel(
         id: 'pv_lvl_$i',
         name: 'Inmersión $i',
         xpReward: 600 + (i * 120),
         tasks: [
           QuestTask(
             id: 'pv_task_sessions_$i',
             description: 'Completa ${5 * i} sesiones de +45 min',
             xpReward: 300 + (i * 60),
             targetValue: (5.0 * i),
             unit: 'sesiones largas',
           ),
         ],
       ));
    }

    return LifeQuest(
      id: 'focus_milestone_3',
      title: 'Profundidad del Vacío',
      description: 'Sesiones largas e interrumpidas.',
      category: 'Foco',
      type: 'milestone',
      levels: levels,
    );
  }

  static String _getLevelName(int level) {
    const names = [
      'Iniciador', 'Aprendiz', 'Observador', 'Concentrado', 'Disciplinado',
      'Inquebrantable', 'Estratega', 'Maestro', 'Sabio', 'Arquitecto del Tiempo',
      'Guardián del Foco', 'Viajero del Vacío', 'Astronauta Mental', 'Explorador Estelar', 'Comandante',
      'Soberano del Silencio', 'Alquimista', 'Zenit', 'Espectro del Foco', 'Maestro Infinito',
      'Leyenda', 'Mito', 'Eterno', 'Cosmos', 'Absoluto'
    ];
    if (level <= names.length) return names[level - 1];
    return 'Rango Superior $level';
  }
}
