import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/service/auth_services.dart';
import 'package:flutter_application_1/utils/session_manager.dart';

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

/// ================= THEME CONTROLLER =================
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

/// ================= PROFILE NAME =================
final ValueNotifier<String> nameNotifier = ValueNotifier("User");

class HomePage extends StatefulWidget {
  final double bmi;
  const HomePage({super.key, required this.bmi});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> workoutChallenges = [
    {
      "title": "Push your limits today!",
      "subtitle": "Full Body Strength",
      "duration": "45 min",
      "calories": "500 kcal",
      "level": "ADVANCED",
      "levelColor": PurplePalette.orchid,
      "levelTextColor": PurplePalette.textPrimary,
      "imageUrl":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuBbs4sJO7xMlqm7jxgDHV3MQp5sd_jGSqxFzLN-PC8b-7a_6W8wbSi9cJnnVIiwWMu_TPiR7sO0vuWpW2Imgug1BTDpHok1GBlGxopoIjtAFzMXf2o0KFNI_Qoq8iaVswrasTDTGHwaloL7lqrp66vwrX5TgCU8aFTqAwrvJJ2Er8jKm-3MlazFEDAHKGbrkK66Jewi8xG1Xlnbd1zuvAJ2nwJXWXiu_gw5jbahMoYz1mcfk3G8Q_V_KaDcyBuYb1vVIAG6BDaHe2o",
    },
    {
      "title": "Morning Cardio",
      "subtitle": "Cardio Workout",
      "duration": "20 min",
      "calories": "250 kcal",
      "level": "CARDIO",
      "levelColor": PurplePalette.info,
      "levelTextColor": PurplePalette.textPrimary,
      "imageUrl":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuASbcElkPJJZIaPe80IO1W9tVXiW71kbOu9_Q2uFNfB3u8PwUSPSA7IplxYIW9NmCWvBPIdhsjct2XAlg-BLrZbNif_cmQXk9PvP5Lg7NcRkKBygX3ODyxR1gwR6Dpw5TBq7ciZ_hrO9mEWtnLQi9h2OGQYisBXU8Gpv9y1u0KjsNDHbI1lmSuW3wfq43i6whbp1uQ_Y_IB918Xn43QfAuW92l6Ob4vuFTxTMCBLRaesEgc8s5DVjZ8BCU_Z4JyBr3ybkixqva08z0",
    },
  ];

  final List<Map<String, dynamic>> completedWorkouts = [
    {
      "title": "Upper Body Strength",
      "duration": "45 Min",
      "calories": "320 Kcal",
      "category": "STRENGTH",
      "categoryColor": PurplePalette.orchid,
      "imageUrl":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuD0r5Lil2-HoDxWibnGSrmwN5joGDPn_D_BRvga3e4tksPamJq2zhffloiFGcCvGbldQMjvDCIDY0YTbofah_UxkYCV2pRxjq_Zmrx9FS9xmAgaOiOIyFvBR4KMLJe1FtI4QsvzQ1jT7J0wTO6SM5_W13e9V2RJKVl3wplvKcyucXK_KLKF8vR9bHvqd2rHuL8Jr0QjCAXi_unz4abwDdH_uBQaJY7HVkVIE3Abr7ErsWpazhB3B6jdJg25KqpMQVnRWZ9QVmDP5WM",
    },
    {
      "title": "Morning Cardio",
      "duration": "30 Min",
      "calories": "210 Kcal",
      "category": "CARDIO",
      "categoryColor": PurplePalette.info,
      "imageUrl":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuDtmqgMr_GVgMbh4eZLWl6QSOII4gHTJ8FHbjYU_prWi8lOHyuwKNgPeA3zUvTWMAEBzi44nxpmI8tD_q7ibp58__v-5XlDb2DbK03jDkK1IKN2dcFPwbp8ahCncqSxIW62Kxz6kwzseuN1ghDhwhx50C3zE68MCtBB7EO8tcJRSAZtKbfKSN7fvRlE9C0k07q3BznJqt7teq5_HGySX_eV1yv0anW3NieJMfixgea1Nnw2HO57gO0d_M443cdAmFmFSS1ULZVE_1w",
    },
    {
      "title": "Leg Day Destruction",
      "duration": "60 Min",
      "calories": "450 Kcal",
      "category": "STRENGTH",
      "categoryColor": PurplePalette.orchid,
      "imageUrl":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuD4mgw2kSFe2qulh1G0K0bdnxNpl6-0M19OAiXaxVHZ_i77MO9D5W_H1onH00qKHT-aUE_kK4sZbjDS9yyb4_waBrqnVQdFiIiTFlhKBoxwLXI6uX81H_21vg4Me8smlueyh4ZKCZJ71ri2jU9N8KQsLpHEEd1ZPvb_1Mib2ApEcScc67w8tTRb4AROjfiwlFGIQZt--zIp2JpXwJfyh4PO6CSQOdcna5Du1F14AiFGmK-V9FwvsE_FO4OsoVMRUxwn6EF0am9R_qM",
    },
  ];

  // Variabel untuk menyimpan data user
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Method untuk memuat data user
  Future<void> _loadUserData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Coba ambil dari cache/local storage terlebih dahulu
      final cachedUserData = await SessionManager.getUserData();
      if (cachedUserData != null) {
        setState(() {
          _userData = cachedUserData;
          _isLoading = false;
        });

        // Update nameNotifier untuk widget lain
        nameNotifier.value = _userData?['nama_lengkap'] ?? 'User';
      }

      // Kemudian fetch fresh data dari API
      final result = await AuthService.getProfile();

      if (result['success'] == true) {
        setState(() {
          _userData = result['data']['pengguna'];
          _isLoading = false;
        });

        // Update nameNotifier untuk widget lain
        nameNotifier.value = _userData?['nama_lengkap'] ?? 'User';
      } else {
        // Jika gagal fetch dari API, tetap gunakan data cache
        if (_userData == null) {
          setState(() {
            _errorMessage = result['message'] ?? 'Gagal memuat data user';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });
    }
  }

  // Method untuk refresh data user
  Future<void> _refreshData() async {
    await _loadUserData();
  }

  // Getter untuk mendapatkan URL foto profile
  String get _profilePhotoUrl {
    if (_userData?['foto_profile_url'] != null) {
      return _userData!['foto_profile_url'];
    }
    if (_userData?['foto_profile'] != null) {
      return 'http://192.168.18.58:8000/profile/${_userData!['foto_profile']}';
    }
    return 'https://i.pinimg.com/474x/07/c4/72/07c4720d19a9e9edad9d0e939eca304a.jpg';
  }

  // Getter untuk nama user
  String get _userName {
    if (_isLoading) return 'Loading...';
    if (_userData?['nama_lengkap'] != null) {
      return _userData!['nama_lengkap'];
    }
    return 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PurplePalette.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          color: PurplePalette.accent,
          backgroundColor: PurplePalette.background,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                /// ================= HEADER =================
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Foto Profile dengan loading state
                          _isLoading
                              ? Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: PurplePalette.cardBackground,
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: PurplePalette.accent,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    // Tampilkan dialog info user
                                    _showUserInfo();
                                  },
                                  child: CircleAvatar(
                                    radius: 26,
                                    backgroundColor:
                                        PurplePalette.cardBackground,
                                    backgroundImage:
                                        _userData?['foto_profile'] != null
                                            ? NetworkImage(_profilePhotoUrl)
                                            : const NetworkImage(
                                                "https://i.pinimg.com/474x/07/c4/72/07c4720d19a9e9edad9d0e939eca304a.jpg",
                                              ) as ImageProvider,
                                  ),
                                ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "WELCOME BACK",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: PurplePalette.textSecondary,
                                ),
                              ),
                              Row(
                                children: [
                                  ValueListenableBuilder<String>(
                                    valueListenable: nameNotifier,
                                    builder: (context, name, child) {
                                      return Text(
                                        "Hi, $_userName",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: PurplePalette.textPrimary,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    FontAwesomeIcons.hands,
                                    color: PurplePalette.accent,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Badge(
                          backgroundColor: PurplePalette.accent,
                          child: Icon(
                            FontAwesomeIcons.bell,
                            color: PurplePalette.textPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ================= ERROR MESSAGE =================
                if (_errorMessage.isNotEmpty)
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.exclamationTriangle,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _errorMessage = '';
                            });
                          },
                          icon: const Icon(
                            FontAwesomeIcons.times,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                /// ================= DAILY CHALLENGE =================
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Workout Challenge",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: PurplePalette.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                /// ================= CHALLENGE CAROUSEL =================
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: workoutChallenges.length,
                    itemBuilder: (context, index) {
                      final challenge = workoutChallenges[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 300,
                          margin: EdgeInsets.only(
                            right:
                                index < workoutChallenges.length - 1 ? 16 : 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image:
                                  NetworkImage(challenge["imageUrl"] as String),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Gradient Overlay
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      PurplePalette.background.withOpacity(0.8),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: challenge["levelColor"],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    challenge["level"],
                                    style: TextStyle(
                                      color: challenge["levelTextColor"],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      challenge["title"],
                                      style: const TextStyle(
                                        color: PurplePalette.textPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      challenge["subtitle"],
                                      style: TextStyle(
                                        color: PurplePalette.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        _buildChallengeInfo(
                                          FontAwesomeIcons.clock,
                                          challenge["duration"],
                                        ),
                                        const SizedBox(width: 16),
                                        _buildChallengeInfo(
                                          FontAwesomeIcons.fire,
                                          challenge["calories"],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),

                /// ================= USER STATS (Optional) =================
                if (_userData != null && !_isLoading)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: PurplePalette.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            PurplePalette.eggplant.withOpacity(0.3),
                            PurplePalette.violet.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _userData!['nama_lengkap'],
                                style: const TextStyle(
                                  color: PurplePalette.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'BMI: ${_userData!['bmi']?.toStringAsFixed(1) ?? widget.bmi.toStringAsFixed(1)}',
                                style: const TextStyle(
                                  color: PurplePalette.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Status: ${_userData!['bmi_category'] ?? 'Normal'}',
                                style: const TextStyle(
                                  color: PurplePalette.lavender,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (_userData?['jenis_kelamin'] != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: PurplePalette.orchid.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: PurplePalette.orchid.withOpacity(0.4),
                                ),
                              ),
                              child: Text(
                                _userData!['jenis_kelamin'] == 'L'
                                    ? 'Laki-laki'
                                    : 'Perempuan',
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
                  ),

                /// ================= COMPLETED WORKOUTS =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Workout History",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: PurplePalette.textPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text(
                              "View All",
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: completedWorkouts.map((workout) {
                      return _buildWorkoutCard(workout);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method untuk menampilkan dialog info user
  void _showUserInfo() {
    if (_userData == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: PurplePalette.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Foto Profile
                CircleAvatar(
                  radius: 50,
                  backgroundColor: PurplePalette.background,
                  backgroundImage: _userData?['foto_profile'] != null
                      ? NetworkImage(_profilePhotoUrl)
                      : const NetworkImage(
                          "https://i.pinimg.com/474x/07/c4/72/07c4720d19a9e9edad9d0e939eca304a.jpg",
                        ) as ImageProvider,
                ),
                const SizedBox(height: 16),

                // Nama Lengkap
                Text(
                  _userData!['nama_lengkap'],
                  style: const TextStyle(
                    color: PurplePalette.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Email
                Text(
                  _userData!['email'],
                  style: const TextStyle(
                    color: PurplePalette.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),

                // Info Tambahan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildUserInfoItem('BMI',
                        '${_userData!['bmi']?.toStringAsFixed(1) ?? '-'}'),
                    _buildUserInfoItem('Gender',
                        _userData!['jenis_kelamin'] == 'L' ? 'Male' : 'Female'),
                    _buildUserInfoItem(
                        'Blood Type', _userData!['golongan_darah'] ?? '-'),
                  ],
                ),
                const SizedBox(height: 20),

                // Button Tutup
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PurplePalette.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(200, 40),
                  ),
                  child: const Text('Tutup'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfoItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: PurplePalette.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: PurplePalette.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: PurplePalette.lavender,
          size: 16,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: PurplePalette.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutCard(Map<String, dynamic> workout) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PurplePalette.cardBackground,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PurplePalette.orchid.withOpacity(0.1),
            PurplePalette.cardBackground,
          ],
        ),
        border: Border.all(
          color: PurplePalette.orchid.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: PurplePalette.orchid.withOpacity(0.1),
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
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  PurplePalette.eggplant.withOpacity(0.8),
                  PurplePalette.violet.withOpacity(0.8),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                workout["imageUrl"] as String,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: PurplePalette.lavender,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          PurplePalette.eggplant.withOpacity(0.8),
                          PurplePalette.violet.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.dumbbell,
                        color: PurplePalette.textPrimary,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout["title"] as String,
                      style: const TextStyle(
                        color: PurplePalette.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: PurplePalette.orchid.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: PurplePalette.orchid.withOpacity(0.4),
                        ),
                      ),
                      child: Text(
                        workout["category"] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildWorkoutDetail(
                      FontAwesomeIcons.clock,
                      workout["duration"] as String,
                    ),
                    const SizedBox(width: 16),
                    _buildWorkoutDetail(
                      FontAwesomeIcons.fire,
                      workout["calories"] as String,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
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

  Widget _buildWorkoutDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: PurplePalette.textSecondary,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: PurplePalette.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
