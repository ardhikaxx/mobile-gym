import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// ================= PALETTE WARNA UNGU =================
class PurplePalette {
  static const Color lavender = Color(0xFFE39FF6);
  static const Color lilac = Color(0xFFBD93D3);
  static const Color amethyst = Color(0xFF9966CC);
  static const Color wildberry = Color(0xFF8B2991);
  static const Color iris = Color(0xFF9866C5);
  static const Color orchid = Color(0xFFAF69EE);
  static const Color periwinkle = Color(0xFFBD93D3);
  static const Color eggplant = Color(0xFF380385);
  static const Color violet = Color(0xFF710193);
  static const Color purple = Color(0xFFA32CC4);
  static const Color mauve = Color(0xFF7A4A88);
  static const Color heather = Color(0xFF9B7CB8);

  static const Color background = Color(0xFF08030C);
  static const Color cardBackground = Color(0xFF2C123A);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFC7B8D6);
  static const Color accent = purple;
  static const Color success = Color(0xFF4CAF50);
  static const Color info = Color(0xFF2196F3);
}

class WorkoutPlanPage extends StatefulWidget {
  const WorkoutPlanPage({super.key});

  @override
  State<WorkoutPlanPage> createState() => _WorkoutPlanPageState();
}

class _WorkoutPlanPageState extends State<WorkoutPlanPage> {
  int _selectedCategory = 0;
  final List<String> _categories = [
    "All",
    "With Equipment",
    "Without Equipment",
  ];
  final List<Color> _categoryColors = [
    PurplePalette.accent,
    PurplePalette.orchid,
    PurplePalette.info,
  ];

  final List<Map<String, dynamic>> equipmentExercises = [
    {
      "title": "Bench Press",
      "description": "Chest compound movement",
      "equipment": "BARBELL",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "25 min",
      "exercises": 4,
      "category": "With Equipment",
    },
    {
      "title": "Lat Pulldown",
      "description": "Back width development",
      "equipment": "CABLE MACHINE",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "20 min",
      "exercises": 3,
      "category": "With Equipment",
    },
    {
      "title": "Leg Extension",
      "description": "Quadriceps isolation",
      "equipment": "MACHINE",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "15 min",
      "exercises": 3,
      "category": "With Equipment",
    },
    {
      "title": "Shoulder Press",
      "description": "Shoulder compound movement",
      "equipment": "DUMBBELL",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "20 min",
      "exercises": 4,
      "category": "With Equipment",
    },
    {
      "title": "T-Bar Row",
      "description": "Back thickness builder",
      "equipment": "BARBELL",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "20 min",
      "exercises": 3,
      "category": "With Equipment",
    },
  ];

  final List<Map<String, dynamic>> bodyweightExercises = [
    {
      "title": "Push-up",
      "description": "Chest and triceps",
      "equipment": "BODYWEIGHT",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "15 min",
      "exercises": 3,
      "category": "Without Equipment",
    },
    {
      "title": "Pull Up",
      "description": "Back and biceps",
      "equipment": "BAR",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "20 min",
      "exercises": 4,
      "category": "Without Equipment",
    },
    {
      "title": "Squat",
      "description": "Leg compound movement",
      "equipment": "BODYWEIGHT",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "15 min",
      "exercises": 3,
      "category": "Without Equipment",
    },
    {
      "title": "Plank",
      "description": "Core stability",
      "equipment": "MAT",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "10 min",
      "exercises": 2,
      "category": "Without Equipment",
    },
    {
      "title": "Russian Twist",
      "description": "Oblique training",
      "equipment": "MAT",
      "icon": Icons.fitness_center,
      "color": PurplePalette.orchid,
      "duration": "10 min",
      "exercises": 2,
      "category": "Without Equipment",
    },
  ];

  List<Map<String, dynamic>> get filteredWorkouts {
    if (_selectedCategory == 0) {
      return [...equipmentExercises, ...bodyweightExercises];
    } else if (_selectedCategory == 1) {
      return equipmentExercises;
    } else {
      return bodyweightExercises;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PurplePalette.background,
      appBar: AppBar(
        backgroundColor: PurplePalette.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Workout Library",
          style: TextStyle(
            color: PurplePalette.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: PurplePalette.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: PurplePalette.mauve.withOpacity(0.5),
                ),
              ),
              child: const Icon(
                FontAwesomeIcons.search,
                color: PurplePalette.textPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// ================= FILTER BUTTONS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = index),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: index < _categories.length - 1 ? 8 : 0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: _selectedCategory == index
                              ? LinearGradient(
                                  colors: [
                                    _categoryColors[index].withOpacity(0.8),
                                    _categoryColors[index],
                                  ],
                                )
                              : null,
                          color: _selectedCategory == index
                              ? null
                              : PurplePalette.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _selectedCategory == index
                                ? _categoryColors[index]
                                : PurplePalette.mauve.withOpacity(0.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: TextStyle(
                              color: _selectedCategory == index
                                  ? PurplePalette.textPrimary
                                  : PurplePalette.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory == 0
                        ? "All Exercises"
                        : _selectedCategory == 1
                            ? "With Equipment"
                            : "Without Equipment",
                    style: const TextStyle(
                      color: PurplePalette.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          "See all",
                          style: TextStyle(
                            color: PurplePalette.lavender,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          FontAwesomeIcons.chevronRight,
                          color: PurplePalette.lavender,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ================= EXERCISES GRID =================
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: filteredWorkouts.length,
                  itemBuilder: (context, index) {
                    final workout = filteredWorkouts[index];
                    return _buildExerciseCard(workout);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> workout) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: PurplePalette.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: PurplePalette.mauve.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: PurplePalette.violet.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      workout["color"].withOpacity(0.3),
                      workout["color"].withOpacity(0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: workout["color"].withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    workout["icon"] as IconData,
                    color: workout["color"] as Color,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                workout["title"],
                style: const TextStyle(
                  color: PurplePalette.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                workout["description"],
                style: const TextStyle(
                  color: PurplePalette.textSecondary,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: workout["color"].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: workout["color"].withOpacity(0.3),
                  ),
                ),
                child: Text(
                  workout["equipment"],
                  style: TextStyle(
                    color: workout["color"],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.clock,
                    color: PurplePalette.textSecondary,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    workout["duration"],
                    style: const TextStyle(
                      color: PurplePalette.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    FontAwesomeIcons.listCheck,
                    color: PurplePalette.textSecondary,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${workout["exercises"]} ex",
                    style: const TextStyle(
                      color: PurplePalette.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}