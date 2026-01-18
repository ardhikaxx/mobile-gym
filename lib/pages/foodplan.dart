import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/service/foodplan_services.dart';
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
  static const Color protein = Color(0xFF4FC3F7); // Biru muda untuk protein
  static const Color carbs = Color(0xFFFFD54F); // Kuning untuk karbohidrat
  static const Color fat = Color(0xFFEF5350); // Merah untuk lemak
  static const Color warning = Color(0xFFFF9800);
}

class FoodPlanPage extends StatefulWidget {
  const FoodPlanPage({super.key});

  @override
  State<FoodPlanPage> createState() => _FoodPlanPageState();
}

class _FoodPlanPageState extends State<FoodPlanPage> {
  int _selectedCategory = 0;
  List<String> categoryNames = ["Pagi", "Siang", "Sore", "Malam"];
  List<String> categoryIds = ["pagi", "siang", "sore", "malam"];
  List<Color> categoryColors = [
    PurplePalette.orchid,
    PurplePalette.info,
    PurplePalette.warning,
    PurplePalette.violet,
  ];

  // State untuk data
  FoodPlanResponse? _foodPlanResponse;
  Map<String, double> _dailyNutrition = {
    'calories': 0,
    'protein': 0,
    'carbs': 0,
    'fat': 0,
  };
  bool _isLoading = true;
  String _errorMessage = '';
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _loadFoodPlan();
    _currentDate = DateFormat('EEEE, dd MMM yyyy').format(DateTime.now());
  }

  Future<void> _loadFoodPlan() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final result = await FoodPlanService.getFoodPlanWithRetry();

    if (result['success'] == true && result['data'] != null) {
      setState(() {
        _foodPlanResponse = result['data'];
        _dailyNutrition = _foodPlanResponse?.getTotalNutrition() ?? _dailyNutrition;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = result['message'] ?? 'Gagal memuat data makanan';
        _isLoading = false;
      });
    }
  }

  List<FoodItem> _getFoodsByCategory(String category) {
    if (_foodPlanResponse == null) return [];
    
    final groupedFoods = _foodPlanResponse!.getGroupedByCategory();
    return groupedFoods[category] ?? [];
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'pagi':
        return FontAwesomeIcons.sun;
      case 'siang':
        return FontAwesomeIcons.sun;
      case 'sore':
        return FontAwesomeIcons.cloudSun;
      case 'malam':
        return FontAwesomeIcons.moon;
      default:
        return FontAwesomeIcons.utensils;
    }
  }


  String _getCategoryTitle(String category) {
    switch (category.toLowerCase()) {
      case 'pagi':
        return 'Sarapan';
      case 'siang':
        return 'Makan Siang';
      case 'sore':
        return 'Camilan Sore';
      case 'malam':
        return 'Makan Malam';
      default:
        return category;
    }
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
            'Memuat data makanan...',
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
            color: PurplePalette.fat,
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
            onPressed: _loadFoodPlan,
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

  Widget _buildNutritionPill(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
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
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 10,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(FoodItem food) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
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
                            food.namaMakanan,
                            style: const TextStyle(
                              color: Colors.white,
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
                              color: PurplePalette.textPrimary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              food.formattedCalories,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implement detail view
                      },
                      icon: const Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  food.deskripsi,
                  style: TextStyle(
                    color: Colors.grey[200],
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
                      value: food.formattedProtein,
                      color: PurplePalette.protein,
                    ),
                    const SizedBox(width: 8),
                    _buildMacroPill(
                      icon: FontAwesomeIcons.breadSlice,
                      value: food.formattedCarbs,
                      color: PurplePalette.carbs,
                    ),
                    const SizedBox(width: 8),
                    _buildMacroPill(
                      icon: FontAwesomeIcons.cheese,
                      value: food.formattedFat,
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealSection(String category) {
    final foods = _getFoodsByCategory(category);
    
    if (foods.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: PurplePalette.mauve.withOpacity(0.2),
          ),
        ),
        child: Center(
          child: Text(
            'Tidak ada makanan untuk $category',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

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
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(category),
                    color: PurplePalette.textPrimary,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _getCategoryTitle(category),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: PurplePalette.textPrimary,
                  ),
                ),
                child: Text(
                  "${foods.length} items",
                  style: const TextStyle(
                    color: PurplePalette.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...foods.map((food) => _buildFoodCard(food)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "FoodPlan Gym",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _loadFoodPlan,
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
            if (_isLoading)
              Expanded(child: _buildLoadingState())
            else if (_errorMessage.isNotEmpty)
              Expanded(child: _buildErrorState())
            else ...[
              /// ================= HEADER CARD =================
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
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
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildNutritionPill(
                              "Calories",
                              "${_dailyNutrition['calories']?.toStringAsFixed(0)} kcal",
                              Colors.white,
                            ),
                            const SizedBox(width: 12),
                            _buildNutritionPill(
                              "Protein",
                              "${_dailyNutrition['protein']?.toStringAsFixed(1)}g",
                              Colors.white,
                            ),
                            const SizedBox(width: 12),
                            _buildNutritionPill(
                              "Carbs",
                              "${_dailyNutrition['carbs']?.toStringAsFixed(1)}g",
                              Colors.white,
                            ),
                            const SizedBox(width: 12),
                            _buildNutritionPill(
                              "Fat",
                              "${_dailyNutrition['fat']?.toStringAsFixed(1)}g",
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
                        color: PurplePalette.textPrimary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PurplePalette.lavender,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.fire,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ================= DATE =================
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.calendar,
                      color: Theme.of(context).primaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _currentDate,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
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
                    categoryNames.length,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategory = index),
                        child: Container(
                          height: 42,
                          margin: EdgeInsets.only(
                            right: index < categoryNames.length - 1 ? 8 : 0,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedCategory == index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: _selectedCategory == index
                                ? [
                                    BoxShadow(
                                      color: categoryColors[index].withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              categoryNames[index],
                              style: TextStyle(
                                color: _selectedCategory == index
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
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
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      if (_selectedCategory == 0 || _selectedCategory == -1)
                        _buildMealSection('pagi'),
                      if (_selectedCategory == 1 || _selectedCategory == -1)
                        _buildMealSection('siang'),
                      if (_selectedCategory == 2 || _selectedCategory == -1)
                        _buildMealSection('sore'),
                      if (_selectedCategory == 3 || _selectedCategory == -1)
                        _buildMealSection('malam'),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}