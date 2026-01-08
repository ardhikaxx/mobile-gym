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

class PenjadwalanPage extends StatefulWidget {
  final double bmi;

  const PenjadwalanPage({super.key, required this.bmi});

  @override
  State<PenjadwalanPage> createState() => _PenjadwalanPageState();
}

class _PenjadwalanPageState extends State<PenjadwalanPage> {
  late String kategori;
  late String goal;
  late String calories;
  late Map<String, String> dietPlan;
  int selectedFilter = 0; // 0: Semua, 1: Kardio, 2: Otot, 3: Yoga

  @override
  void initState() {
    super.initState();
    _setDietFromBMI();
  }

  /// ================= LOGIC DIET =================
  void _setDietFromBMI() {
    final bmiText = widget.bmi;

    if (bmiText < 18.5) {
      kategori = "Bulking";
      goal = "Menaikkan Berat Badan Sehat";
      calories = "±3000 kkal / hari";
      dietPlan = {
        "Pagi": "Nasi + Telur + Susu Full Cream",
        "Snack 1": "Pisang + Kacang",
        "Siang": "Nasi + Ayam + Sayur",
        "Snack 2": "Roti Gandum + Selai",
        "Malam": "Nasi + Ikan + Tempe",
      };
    } else if (bmiText >= 18.5 && bmiText <= 24.9) {
      kategori = "Maintenance";
      goal = "Menjaga Berat & Energi Tubuh";
      calories = "±2200 kkal / hari";
      dietPlan = {
        "Pagi": "Oatmeal + Telur Rebus",
        "Snack 1": "Buah",
        "Siang": "Nasi Merah + Ayam",
        "Snack 2": "Yogurt",
        "Malam": "Ikan + Sayur",
      };
    } else {
      kategori = "Diet";
      goal = "Menurunkan Lemak Tubuh";
      calories = "±1700 kkal / hari";
      dietPlan = {
        "Pagi": "Oatmeal / Telur Rebus",
        "Snack 1": "Apel / Pepaya",
        "Siang": "Nasi Merah + Ayam Panggang",
        "Snack 2": "Kacang Almond",
        "Malam": "Sup Sayur + Tahu",
      };
    }
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PurplePalette.background,
      appBar: AppBar(
        backgroundColor: PurplePalette.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: PurplePalette.textPrimary),
        ),
        title: const Text(
          "Jadwal Workout",
          style: TextStyle(
            color: PurplePalette.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
                Icons.more_vert,
                color: PurplePalette.textPrimary,
                size: 26,
              ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedFilter = 0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedFilter == 0
                              ? PurplePalette.accent
                              : PurplePalette.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedFilter == 0
                                ? PurplePalette.accent
                                : PurplePalette.mauve,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Semua",
                            style: TextStyle(
                              color: selectedFilter == 0
                                  ? PurplePalette.textPrimary
                                  : PurplePalette.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedFilter = 1),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedFilter == 1
                              ? PurplePalette.info
                              : PurplePalette.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedFilter == 1
                                ? PurplePalette.info
                                : PurplePalette.mauve,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Kardio",
                            style: TextStyle(
                              color: selectedFilter == 1
                                  ? PurplePalette.textPrimary
                                  : PurplePalette.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedFilter = 2),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedFilter == 2
                              ? PurplePalette.orchid
                              : PurplePalette.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedFilter == 2
                                ? PurplePalette.orchid
                                : PurplePalette.mauve,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Otot",
                            style: TextStyle(
                              color: selectedFilter == 2
                                  ? PurplePalette.textPrimary
                                  : PurplePalette.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedFilter = 3),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedFilter == 3
                              ? PurplePalette.lavender
                              : PurplePalette.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedFilter == 3
                                ? PurplePalette.lavender
                                : PurplePalette.mauve,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Yoga",
                            style: TextStyle(
                              color: selectedFilter == 3
                                  ? Colors.black
                                  : PurplePalette.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= DATE HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "24 October 2025",
                        style: TextStyle(
                          color: PurplePalette.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Hari ini",
                        style: TextStyle(
                          color: PurplePalette.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: PurplePalette.wildberry.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: PurplePalette.wildberry,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.fitness_center,
                          color: PurplePalette.lavender,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "3 Workouts",
                          style: TextStyle(
                            color: PurplePalette.lavender,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// ================= WORKOUT LIST =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    _buildWorkoutCard(
                      title: "Morning Run",
                      category: "CARDIO",
                      time: "07:00",
                      duration: "30 min",
                      iconData: FontAwesomeIcons.running,
                      color: PurplePalette.orchid,
                      iconColor: PurplePalette.orchid,
                    ),
                    const SizedBox(height: 10),
                    _buildWorkoutCard(
                      title: "Chest & Triceps",
                      category: "STRENGTH",
                      time: "18:30",
                      duration: "45 min",
                      iconData: FontAwesomeIcons.dumbbell,
                      color: PurplePalette.orchid,
                      iconColor: PurplePalette.orchid,
                    ),
                    const SizedBox(height: 10),
                    _buildWorkoutCard(
                      title: "Evening Walk",
                      category: "CARDIO",
                      time: "21:00",
                      duration: "25 min",
                      iconData: FontAwesomeIcons.walking,
                      color: PurplePalette.orchid,
                      iconColor: PurplePalette.orchid,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard({
    required String title,
    required String category,
    required String time,
    required String duration,
    required IconData iconData,
    required Color color,
    required Color iconColor,
    bool isTomorrow = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PurplePalette.cardBackground,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            PurplePalette.cardBackground,
          ],
        ),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                iconData,
                color: iconColor,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: PurplePalette.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isTomorrow)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: PurplePalette.eggplant.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: PurplePalette.iris,
                          ),
                        ),
                        child: const Text(
                          "BESOK",
                          style: TextStyle(
                            color: PurplePalette.lavender,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: color.withOpacity(0.4),
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.access_time,
                      color: PurplePalette.textSecondary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        color: PurplePalette.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "•",
                      style: TextStyle(
                        color: PurplePalette.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: PurplePalette.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.chevronRight,
              color: PurplePalette.textSecondary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}