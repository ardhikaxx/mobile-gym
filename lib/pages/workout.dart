import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/service/workout_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';

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
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);

  // Workout category colors
  static const Color equipmentColor =
      Color(0xFF4FC3F7); // Biru untuk with equipment
  static const Color bodyweightColor =
      Color(0xFF66BB6A); // Hijau untuk without equipment
  static const Color completedColor =
      Color(0xFF4CAF50); // Hijau untuk completed
  static const Color progressColor =
      Color(0xFFFF9800); // Orange untuk in progress
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
    PurplePalette.equipmentColor,
    PurplePalette.bodyweightColor,
  ];

  // State untuk data
  WorkoutResponse? _workoutResponse;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final result = await WorkoutService.getTodayWorkoutsWithRetry();

    if (result['success'] == true && result['data'] != null) {
      setState(() {
        _workoutResponse = result['data'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = result['message'] ?? 'Gagal memuat data workout';
        _isLoading = false;
      });
    }
  }

  List<Workout> _getFilteredWorkouts() {
    if (_workoutResponse == null) return [];

    if (_selectedCategory == 0) {
      return _workoutResponse!.workouts;
    } else if (_selectedCategory == 1) {
      return _workoutResponse!.workouts
          .where((workout) =>
              !workout.equipment.toLowerCase().contains('no equipment') &&
              !workout.equipment.toLowerCase().contains('bodyweight') &&
              workout.equipment.isNotEmpty)
          .toList();
    } else {
      return _workoutResponse!.workouts
          .where((workout) =>
              workout.equipment.toLowerCase().contains('no equipment') ||
              workout.equipment.toLowerCase().contains('bodyweight') ||
              workout.equipment.isEmpty)
          .toList();
    }
  }

  Color _getStatusColor(Workout workout) {
    if (workout.isCompleted) {
      return PurplePalette.completedColor;
    } else if (workout.isStarted) {
      return PurplePalette.progressColor;
    }
    return PurplePalette.textSecondary;
  }

  IconData _getStatusIcon(Workout workout) {
    if (workout.isCompleted) {
      return FontAwesomeIcons.checkCircle;
    } else if (workout.isStarted) {
      return FontAwesomeIcons.playCircle;
    }
    return FontAwesomeIcons.clock;
  }

  IconData _getWorkoutIcon(Workout workout) {
    if (workout.kategori.toLowerCase().contains('yoga')) {
      return FontAwesomeIcons.spa;
    } else if (workout.kategori.toLowerCase().contains('cardio')) {
      return FontAwesomeIcons.running;
    } else if (workout.kategori.toLowerCase().contains('strength') ||
        workout.kategori.toLowerCase().contains('muscle')) {
      return FontAwesomeIcons.dumbbell;
    }
    return FontAwesomeIcons.fire;
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 20),
          Text(
            'Memuat data workout...',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.exclamationTriangle,
            color: PurplePalette.error,
            size: 64,
          ),
          const SizedBox(height: 20),
          Text(
            _errorMessage,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadWorkouts,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text(
              'Coba Lagi',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.dumbbell,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            size: 64,
          ),
          const SizedBox(height: 20),
          Text(
            'Tidak ada workout hari ini',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Lihat jadwal workout untuk menambahkan kegiatan',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(Workout workout) {
    final statusColor = _getStatusColor(workout);
    final statusIcon = _getStatusIcon(workout);
    final workoutIcon = _getWorkoutIcon(workout);

    return GestureDetector(
      onTap: () {
        // TODO: navigasi ke halaman camera workout
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: PurplePalette.mauve.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: PurplePalette.orchid.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          workoutIcon,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'detail') {
                          // TODO: Show workout detail
                        } else if (value == 'start') {
                          // TODO: Start workout
                        }
                      },
                      icon: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          ),
                        ),
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem<String>(
                          value: 'detail',
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.infoCircle, size: 16),
                              SizedBox(width: 8),
                              Text('Detail'),
                            ],
                          ),
                        ),
                        if (!workout.isCompleted)
                          const PopupMenuItem<String>(
                            value: 'start',
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.play, size: 16),
                                SizedBox(width: 8),
                                Text('Mulai Workout'),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  workout.namaWorkout,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  workout.deskripsi,
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: PurplePalette.orchid.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        workout.equipment.isNotEmpty
                            ? workout.equipment
                            : 'No Equipment',
                        style: const TextStyle(
                          color: PurplePalette.orchid,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: statusColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            statusIcon,
                            color: statusColor,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            workout.statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (workout.jadwal != null) ...[
                      Icon(
                        FontAwesomeIcons.clock,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        workout.jadwal!.formattedTime,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Icon(
                      FontAwesomeIcons.listCheck,
                      color: Colors.white,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      workout.formattedExercises,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    if (workout.jadwal != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          workout.jadwal!.kategoriJadwal,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);
    final filteredWorkouts = _getFilteredWorkouts();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Workout Plan",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            onPressed: _loadWorkouts,
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// ================= FILTER BUTTONS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8),
                                    Theme.of(context).primaryColor,
                                  ],
                                )
                              : null,
                          color: _selectedCategory == index
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _selectedCategory == index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).primaryColor,
                          ),
                          boxShadow: _selectedCategory == index
                              ? [
                                  BoxShadow(
                                    color:
                                        _categoryColors[index].withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            _categories[index],
                            style: TextStyle(
                              color: _selectedCategory == index
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
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

            /// ================= HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory == 0
                        ? "All Workouts"
                        : _selectedCategory == 1
                            ? "With Equipment"
                            : "Without Equipment",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_workoutResponse != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${filteredWorkouts.length} items",
                        style: const TextStyle(
                          color: PurplePalette.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// ================= WORKOUTS LIST =================
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _errorMessage.isNotEmpty
                      ? _buildErrorState()
                      : filteredWorkouts.isEmpty
                          ? _buildEmptyState()
                          : SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Column(
                                children: [
                                  ...filteredWorkouts.map(
                                      (workout) => _buildWorkoutCard(workout)),
                                  const SizedBox(height: 80),
                                ],
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
