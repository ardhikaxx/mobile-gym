import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/themes.dart';
import 'package:flutter_application_1/utils/session_manager.dart';
import 'firebase_options.dart';

import 'auth/login.dart';
import 'auth/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GymApp());
}

class GymApp extends StatefulWidget {
  const GymApp({super.key});

  @override
  State<GymApp> createState() => _GymAppState();
}

class _GymAppState extends State<GymApp> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await SessionManager.getAuthToken();
    final userData = await SessionManager.getUserData();
    
    setState(() {
      _isLoggedIn = token != null && token.isNotEmpty;
      if (userData != null && userData['bmi'] != null) {
      }
      _isLoading = false;
    });
    
    // Jika token tidak ada, pastikan diarahkan ke login
    if (!_isLoggedIn && !_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      });
    }
  }

  // Fungsi untuk mengecek token secara global
  Future<bool> _checkTokenBeforeNavigation() async {
    final token = await SessionManager.getAuthToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFF08030C),
          body: Center(
            child: CircularProgressIndicator(
              color: Color(0xFFA32CC4),
            ),
          ),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GYM GENZ',
            navigatorKey: _navigatorKey,
            theme: ThemeClass.lightTheme,
            darkTheme: ThemeClass.darkTheme,
            themeMode: themeProvider.materialThemeMode,
            initialRoute: _isLoggedIn ? '/login' : '/register',
            routes: {
              '/login': (_) => const LoginPage(),
              '/register': (_) => const RegisterPage(),
            },
            onGenerateRoute: (settings) {
              if (settings.name != '/login' && 
                  settings.name != '/register') {
                _checkTokenBeforeNavigation().then((isValid) {
                  if (!isValid && _navigatorKey.currentState != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _navigatorKey.currentState?.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                    });
                  }
                });
              }
              return null;
            },
          );
        },
      ),
    );
  }
}