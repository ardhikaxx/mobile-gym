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
  static const Color protein = Color(0xFF4FC3F7); // Biru muda untuk protein
  static const Color carbs = Color(0xFFFFD54F); // Kuning untuk karbohidrat
  static const Color fat = Color(0xFFEF5350); // Merah untuk lemak
}

class FoodPlanPage extends StatefulWidget {
  const FoodPlanPage({super.key});

  @override
  State<FoodPlanPage> createState() => _FoodPlanPageState();
}

class _FoodPlanPageState extends State<FoodPlanPage> {
  int selectedPlan = 0; // 0: Bulking, 1: Cutting, 2: Diet
  final List<String> planNames = ["Pagi", "Siang", "Malam"];
  final List<Color> planColors = [
    PurplePalette.orchid,
    PurplePalette.info,
    PurplePalette.success,
  ];

  final List<Map<String, String>> breakfastItems = const [
    {
      "name": "Oatmeal & Whey",
      "description": "Rolled oats, vanilla whey protein, blueberries, almond...",
      "calories": "450 kcal",
      "protein": "30g P",
      "carbs": "50g C",
      "fat": "10g F",
    },
    {
      "name": "Greek Yogurt Parfait",
      "description": "Low-fat greek yogurt, honey, gluten-free granola.",
      "calories": "200 kcal",
      "protein": "15g P",
      "carbs": "20g C",
      "fat": "5g F",
    },
    {
      "name": "Steak & Sweet Potato",
      "description": "Grilled sirloin, baked sweet potato, steamed broccoli.",
      "calories": "800 kcal",
      "protein": "60g P",
      "carbs": "60g C",
      "fat": "30g F",
    },
  ];

  final List<Map<String, String>> lunchItems = const [
    {
      "name": "Grilled Salmon Salad",
      "description": "Fresh atlantic salmon, mixed greens, avocado, lemon...",
      "calories": "600 kcal",
      "protein": "45g P",
      "carbs": "15g C",
      "fat": "25g F",
    },
  ];

  final List<Map<String, String>> snackItems = const [
    {
      "name": "Greek Yogurt Parfait",
      "description": "Low-fat greek yogurt, honey, gluten-free granola.",
      "calories": "200 kcal",
      "protein": "15g P",
      "carbs": "20g C",
      "fat": "5g F",
    },
  ];

  final List<Map<String, String>> dinnerItems = const [
    {
      "name": "Steak & Sweet Potato",
      "description": "Grilled sirloin, baked sweet potato, steamed broccoli.",
      "calories": "800 kcal",
      "protein": "60g P",
      "carbs": "60g C",
      "fat": "30g F",
    },
  ];

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
          "Meal Plan Gym",
          style: TextStyle(
            color: PurplePalette.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// ================= HEADER CARD =================
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PurplePalette.cardBackground,
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    PurplePalette.eggplant.withOpacity(0.8),
                    PurplePalette.violet.withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: PurplePalette.violet.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Daily Nutrition",
                        style: TextStyle(
                          color: PurplePalette.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildNutritionPill(
                            "Calories",
                            "2050 kcal",
                            Colors.white,
                          ),
                          const SizedBox(width: 12),
                          _buildNutritionPill(
                            "Protein",
                            "150g",
                            Colors.white,
                          ),
                          const SizedBox(width: 12),
                          _buildNutritionPill(
                            "Carbs",
                            "155g",
                            Colors.white,
                          ),
                          const SizedBox(width: 12),
                          _buildNutritionPill(
                            "Fat",
                            "70g",
                            Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: PurplePalette.lavender.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: PurplePalette.lavender,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.fire,
                        color: PurplePalette.lavender,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// ================= DATE =================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: PurplePalette.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: PurplePalette.mauve.withOpacity(0.5),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.calendar,
                    color: PurplePalette.lilac,
                    size: 16,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Today, 24 Oct 2025",
                    style: TextStyle(
                      color: PurplePalette.lilac,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= FILTER BUTTONS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(
                  planNames.length,
                  (index) => Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedPlan = index),
                      child: Container(
                        height: 42,
                        margin: EdgeInsets.only(
                          right: index < planNames.length - 1 ? 8 : 0,
                        ),
                        decoration: BoxDecoration(
                          gradient: selectedPlan == index
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    planColors[index].withOpacity(0.8),
                                    planColors[index],
                                  ],
                                )
                              : null,
                          color: selectedPlan == index
                              ? null
                              : PurplePalette.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedPlan == index
                                ? planColors[index]
                                : PurplePalette.mauve.withOpacity(0.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            planNames[index],
                            style: TextStyle(
                              color: selectedPlan == index
                                  ? PurplePalette.textPrimary
                                  : PurplePalette.textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ================= MEAL SECTIONS =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    _buildMealSection(
                      title: "Breakfast",
                      icon: FontAwesomeIcons.sun,
                      items: breakfastItems,
                      iconColor: PurplePalette.carbs,
                    ),
                    const SizedBox(height: 20),
                    _buildMealSection(
                      title: "Lunch",
                      icon: FontAwesomeIcons.sun,
                      items: lunchItems,
                      iconColor: PurplePalette.orchid,
                    ),
                    const SizedBox(height: 20),
                    _buildMealSection(
                      title: "Snack",
                      icon: FontAwesomeIcons.cookieBite,
                      items: snackItems,
                      iconColor: PurplePalette.lavender,
                    ),
                    const SizedBox(height: 20),
                    _buildMealSection(
                      title: "Dinner",
                      icon: FontAwesomeIcons.moon,
                      items: dinnerItems,
                      iconColor: PurplePalette.info,
                    ),
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

  Widget _buildNutritionPill(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: PurplePalette.textSecondary,
              fontSize: 10,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealSection({
    required String title,
    required IconData icon,
    required List<Map<String, String>> items,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: iconColor.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: PurplePalette.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
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
                child: Text(
                  "${items.length} items",
                  style: const TextStyle(
                    color: PurplePalette.lavender,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildFoodCard(item: item);
          },
        ),
      ],
    );
  }

  Widget _buildFoodCard({required Map<String, String> item}) {
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
            PurplePalette.eggplant.withOpacity(0.3),
            PurplePalette.cardBackground,
          ],
        ),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  PurplePalette.orchid.withOpacity(0.3),
                  PurplePalette.lavender.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: PurplePalette.orchid.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(
                FontAwesomeIcons.bowlFood,
                color: PurplePalette.orchid,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"]!,
                            style: const TextStyle(
                              color: PurplePalette.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: PurplePalette.wildberry.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: PurplePalette.wildberry,
                              ),
                            ),
                            child: Text(
                              item["calories"]!,
                              style: const TextStyle(
                                color: PurplePalette.lavender,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
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
                const SizedBox(height: 8),
                Text(
                  item["description"]!,
                  style: const TextStyle(
                    color: PurplePalette.textSecondary,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildMacroPill(
                      icon: FontAwesomeIcons.drumstickBite,
                      value: item["protein"]!,
                      color: PurplePalette.protein,
                    ),
                    const SizedBox(width: 12),
                    _buildMacroPill(
                      icon: FontAwesomeIcons.breadSlice,
                      value: item["carbs"]!,
                      color: PurplePalette.carbs,
                    ),
                    const SizedBox(width: 12),
                    _buildMacroPill(
                      icon: FontAwesomeIcons.cheese,
                      value: item["fat"]!,
                      color: PurplePalette.fat,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroPill({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              color: PurplePalette.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}