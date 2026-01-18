import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/service/auth_services.dart';
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
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _tinggiBadanController = TextEditingController();
  final _beratBadanController = TextEditingController();
  final _alergiController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _jenisKelamin;
  String? _golonganDarah;
  File? _fotoProfile;
  String _errorMessage = '';

  final List<Map<String, dynamic>> _golonganDarahList = [
    {'value': null, 'label': 'Pilih Golongan Darah'},
    {'value': 'A', 'label': 'A'},
    {'value': 'B', 'label': 'B'},
    {'value': 'AB', 'label': 'AB'},
    {'value': 'O', 'label': 'O'},
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (image != null) {
        setState(() {
          _fotoProfile = File(image.path);
        });
      }
    } catch (e) {
      _showSnackBar('Gagal memilih gambar: $e');
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_jenisKelamin == null) {
      _showSnackBar('Pilih jenis kelamin terlebih dahulu');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final result = await AuthService.register(
        namaLengkap: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
        jenisKelamin: _jenisKelamin!,
        tinggiBadan: _tinggiBadanController.text.isNotEmpty
            ? double.tryParse(_tinggiBadanController.text)
            : null,
        beratBadan: _beratBadanController.text.isNotEmpty
            ? double.tryParse(_beratBadanController.text)
            : null,
        alergi: _alergiController.text.isNotEmpty
            ? _alergiController.text.trim()
            : null,
        golonganDarah: _golonganDarah,
        fotoProfile: _fotoProfile,
      );

      if (result['success'] == true) {
        // Registrasi berhasil, arahkan ke login
        if (mounted) {
          _showSuccessDialog();
        }
      } else {
        setState(() {
          _errorMessage = result['message'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    Provider.of<ThemeProvider>(context, listen: false);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
          ),
        ),
        title: Text(
          "Registrasi Berhasil!",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.userCheck,
              color: Theme.of(context).primaryColor,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              "Akun Anda telah berhasil dibuat.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Silakan login untuk melanjutkan.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  PurplePalette.eggplant.withOpacity(0.8),
                  PurplePalette.violet.withOpacity(0.8),
                ],
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Login Sekarang"),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  String? _validateNama(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama lengkap wajib diisi';
    }
    if (value.length < 3) {
      return 'Nama minimal 3 karakter';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email wajib diisi';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password wajib diisi';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }
    if (value != _passwordController.text) {
      return 'Password tidak cocok';
    }
    return null;
  }

  String? _validateTinggiBadan(String? value) {
    if (value != null && value.isNotEmpty) {
      final tinggi = double.tryParse(value);
      if (tinggi == null) {
        return 'Masukkan angka yang valid';
      }
      if (tinggi < 50 || tinggi > 250) {
        return 'Tinggi badan harus antara 50-250 cm';
      }
    }
    return null;
  }

  String? _validateBeratBadan(String? value) {
    if (value != null && value.isNotEmpty) {
      final berat = double.tryParse(value);
      if (berat == null) {
        return 'Masukkan angka yang valid';
      }
      if (berat < 20 || berat > 300) {
        return 'Berat badan harus antara 20-300 kg';
      }
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _tinggiBadanController.dispose();
    _beratBadanController.dispose();
    _alergiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          final isDesktop = c.maxWidth > 900;
          return isDesktop ? _desktop(themeProvider) : _mobile(themeProvider);
        },
      ),
    );
  }

  /// ================= DESKTOP =================
  Widget _desktop(ThemeProvider themeProvider) {
    return Row(
      children: [
        _leftInfo(themeProvider),
        Container(width: 1, color: Theme.of(context).dividerColor),
        Expanded(child: _form(themeProvider)),
      ],
    );
  }

  /// ================= MOBILE =================
  Widget _mobile(ThemeProvider themeProvider) {
    return SingleChildScrollView(
      child: _form(themeProvider),
    );
  }

  /// ================= LEFT INFO =================
  Widget _leftInfo(ThemeProvider themeProvider) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              PurplePalette.eggplant.withOpacity(0.9),
              PurplePalette.violet.withOpacity(0.9),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              child: const Icon(
                FontAwesomeIcons.userPlus,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Bergabung dengan GYM GENZ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Mulai perjalanan fitness Anda dengan komunitas yang mendukung. "
              "Dapatkan akses ke program latihan personal, pelacakan progres, "
              "dan nutrisi yang disesuaikan.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                _buildFeatureIcon(
                    FontAwesomeIcons.dumbbell, "Program Personal"),
                const SizedBox(width: 20),
                _buildFeatureIcon(
                    FontAwesomeIcons.chartLine, "Pelacakan Progres"),
                const SizedBox(width: 20),
                _buildFeatureIcon(FontAwesomeIcons.utensils, "Rencana Nutrisi"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String text) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// ================= FORM =================
  Widget _form(ThemeProvider themeProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Buat Akun Baru",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Bergabung dan mulai perjalanan fitness Anda!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 20),

            /// ================= ERROR MESSAGE =================
            if (_errorMessage.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
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

            /// ================= FOTO PROFILE =================
            GestureDetector(
              onTap: _pickImage,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            PurplePalette.orchid,
                            PurplePalette.lavender,
                          ],
                        ),
                        border: Border.all(
                          color: PurplePalette.lavender,
                          width: 3,
                        ),
                      ),
                      child: _fotoProfile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _fotoProfile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              FontAwesomeIcons.camera,
                              color: Colors.white,
                              size: 30,
                            ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _fotoProfile != null ? "Ubah Foto" : "Tambahkan Foto",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// ================= NAMA LENGKAP =================
            _buildTextField(
              context: context,
              controller: _nameController,
              label: "Nama Lengkap",
              hint: "Masukkan nama lengkap Anda",
              icon: FontAwesomeIcons.user,
              validator: _validateNama,
            ),

            const SizedBox(height: 20),

            /// ================= EMAIL =================
            _buildTextField(
              context: context,
              controller: _emailController,
              label: "Email",
              hint: "Masukkan email Anda",
              icon: FontAwesomeIcons.envelope,
              validator: _validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 20),

            /// ================= PASSWORD =================
            _buildPasswordField(
              context: context,
              controller: _passwordController,
              label: "Password",
              hint: "Masukkan password Anda",
              obscureText: _obscurePassword,
              onToggleObscure: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              validator: _validatePassword,
            ),

            const SizedBox(height: 20),

            /// ================= KONFIRMASI PASSWORD =================
            _buildPasswordField(
              context: context,
              controller: _confirmPasswordController,
              label: "Konfirmasi Password",
              hint: "Masukkan ulang password Anda",
              obscureText: _obscureConfirmPassword,
              onToggleObscure: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              validator: _validateConfirmPassword,
            ),

            const SizedBox(height: 20),

            /// ================= JENIS KELAMIN =================
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jenis Kelamin *",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildGenderOption(
                        context: context,
                        value: 'L',
                        label: 'Laki-laki',
                        icon: FontAwesomeIcons.mars,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildGenderOption(
                        context: context,
                        value: 'P',
                        label: 'Perempuan',
                        icon: FontAwesomeIcons.venus,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "* Wajib dipilih",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ================= TINGGI & BERAT BADAN =================
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    context: context,
                    controller: _tinggiBadanController,
                    label: "Tinggi Badan (cm)",
                    hint: "Contoh: 175 (50-250 cm)",
                    icon: FontAwesomeIcons.rulerVertical,
                    validator: _validateTinggiBadan,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    context: context,
                    controller: _beratBadanController,
                    label: "Berat Badan (kg)",
                    hint: "Contoh: 70 (20-300 kg)",
                    icon: FontAwesomeIcons.weight,
                    validator: _validateBeratBadan,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ================= ALERGI =================
            _buildTextField(
              context: context,
              controller: _alergiController,
              label: "Alergi (Opsional)",
              hint: "Contoh: udang, kacang, seafood",
              icon: FontAwesomeIcons.exclamationTriangle,
              maxLines: 2,
            ),

            const SizedBox(height: 20),

            /// ================= GOLONGAN DARAH (DROPDOWN) =================
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Golongan Darah",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _golonganDarah,
                      isExpanded: true,
                      dropdownColor: Theme.of(context).cardColor,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(
                          FontAwesomeIcons.chevronDown,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          size: 18,
                        ),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          "Pilih Golongan Darah",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                      items: _golonganDarahList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item['value'],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              item['label'],
                              style: TextStyle(
                                color: item['value'] == null
                                    ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _golonganDarah = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Pilih golongan darah Anda (opsional)",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            /// ================= DAFTAR BUTTON =================
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    PurplePalette.eggplant.withOpacity(0.8),
                    PurplePalette.violet.withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.userPlus,
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Daftar Sekarang",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 20),

            /// ================= LOGIN LINK =================
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: hint,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscureText,
    required VoidCallback onToggleObscure,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: hint,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            prefixIcon: Icon(
              FontAwesomeIcons.lock,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: onToggleObscure,
              icon: Icon(
                obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                size: 20,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required BuildContext context,
    required String value,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _jenisKelamin == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _jenisKelamin = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}