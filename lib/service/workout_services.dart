import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/service/connect.dart';
import 'package:flutter_application_1/utils/session_manager.dart';

// Model untuk Exercise
class Exercise {
  final int id;
  final String namaExercise;
  final String deskripsi;
  final String equipment;
  final String kategori;
  final int repetitions;
  final int sets;
  final String durasi;
  final String videoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Exercise({
    required this.id,
    required this.namaExercise,
    required this.deskripsi,
    required this.equipment,
    required this.kategori,
    required this.repetitions,
    required this.sets,
    required this.durasi,
    required this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? 0,
      namaExercise: json['nama_exercise'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      equipment: json['equipment'] ?? '',
      kategori: json['kategori'] ?? '',
      repetitions: json['repetitions'] ?? 0,
      sets: json['sets'] ?? 0,
      durasi: json['durasi'] ?? '0 menit',
      videoUrl: json['video_url'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
    );
  }

  String get formattedSetsReps => '$sets sets × $repetitions reps';
  String get formattedEquipment => equipment.isNotEmpty ? equipment : 'No Equipment';
}

// Model untuk Workout
class Workout {
  final int id;
  final String namaWorkout;
  final String deskripsi;
  final String equipment;
  final String kategori;
  final int exercises;
  final String status;
  final int jadwalWorkoutId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final JadwalInfo? jadwal;

  Workout({
    required this.id,
    required this.namaWorkout,
    required this.deskripsi,
    required this.equipment,
    required this.kategori,
    required this.exercises,
    required this.status,
    required this.jadwalWorkoutId,
    required this.createdAt,
    required this.updatedAt,
    this.jadwal,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] ?? 0,
      namaWorkout: json['nama_workout'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      equipment: json['equipment'] ?? '',
      kategori: json['kategori'] ?? '',
      exercises: json['exercises'] ?? 0,
      status: json['status'] ?? 'belum',
      jadwalWorkoutId: json['jadwal_workout_id'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
      jadwal: json['jadwal'] != null ? JadwalInfo.fromJson(json['jadwal']) : null,
    );
  }

  // Helper methods
  bool get isCompleted => status.toLowerCase() == 'selesai';
  bool get isStarted => status.toLowerCase() == 'sedang';
  bool get isNotStarted => status.toLowerCase() == 'belum';

  String get statusText {
    switch (status.toLowerCase()) {
      case 'selesai':
        return 'Completed';
      case 'sedang':
        return 'In Progress';
      case 'belum':
        return 'Not Started';
      default:
        return status;
    }
  }

  String get statusColor {
    switch (status.toLowerCase()) {
      case 'selesai':
        return 'success';
      case 'sedang':
        return 'warning';
      case 'belum':
        return 'default';
      default:
        return 'default';
    }
  }

  String get formattedExercises => '$exercises ${exercises == 1 ? 'exercise' : 'exercises'}';

  // Get workout icon berdasarkan kategori
  String get workoutIcon {
    if (kategori.toLowerCase().contains('yoga')) return '🧘';
    if (kategori.toLowerCase().contains('cardio')) return '🏃';
    if (kategori.toLowerCase().contains('strength') || kategori.toLowerCase().contains('muscle')) return '🏋️';
    if (kategori.toLowerCase().contains('hiit')) return '⚡';
    if (equipment.toLowerCase().contains('bodyweight') || equipment.toLowerCase().contains('no equipment')) return '🤸';
    return '💪';
  }

  // Get workout color berdasarkan kategori
  String get workoutColor {
    if (kategori.toLowerCase().contains('yoga') || kategori.toLowerCase().contains('flexibility')) return 'yoga';
    if (kategori.toLowerCase().contains('cardio')) return 'cardio';
    if (kategori.toLowerCase().contains('strength') || kategori.toLowerCase().contains('muscle')) return 'strength';
    if (kategori.toLowerCase().contains('hiit')) return 'hiit';
    if (equipment.toLowerCase().contains('bodyweight') || equipment.toLowerCase().contains('no equipment')) return 'bodyweight';
    return 'equipment';
  }
}

// Model untuk Jadwal Info (embedded dalam Workout)
class JadwalInfo {
  final int id;
  final String namaJadwal;
  final String kategoriJadwal;
  final DateTime tanggal;
  final String jam;
  final String durasiWorkout;

  JadwalInfo({
    required this.id,
    required this.namaJadwal,
    required this.kategoriJadwal,
    required this.tanggal,
    required this.jam,
    required this.durasiWorkout,
  });

  factory JadwalInfo.fromJson(Map<String, dynamic> json) {
    return JadwalInfo(
      id: json['id'] ?? 0,
      namaJadwal: json['nama_jadwal'] ?? '',
      kategoriJadwal: json['kategori_jadwal'] ?? '',
      tanggal: DateTime.parse(json['tanggal'] ?? DateTime.now().toString()),
      jam: json['jam'] ?? '00:00',
      durasiWorkout: json['durasi_workout'] ?? '0 menit',
    );
  }

  String get formattedTime {
    try {
      final timeParts = jam.split(':');
      if (timeParts.length >= 2) {
        final hour = int.parse(timeParts[0]);
        final minute = timeParts[1];
        final period = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : hour == 0 ? 12 : hour;
        return '${displayHour.toString().padLeft(2, '0')}:$minute $period';
      }
      return jam;
    } catch (e) {
      return jam;
    }
  }
}

// Model untuk Workout Response
class WorkoutResponse {
  final List<Workout> workouts;
  final String date;
  final int totalJadwals;
  final int totalWorkouts;

  WorkoutResponse({
    required this.workouts,
    required this.date,
    required this.totalJadwals,
    required this.totalWorkouts,
  });

  factory WorkoutResponse.fromJson(Map<String, dynamic> json) {
    List<Workout> workoutList = [];
    
    if (json['data'] != null && json['data'] is List) {
      workoutList = (json['data'] as List)
          .map((item) => Workout.fromJson(item))
          .toList();
    }

    return WorkoutResponse(
      workouts: workoutList,
      date: json['date'] ?? DateTime.now().toString(),
      totalJadwals: json['total_jadwals'] ?? 0,
      totalWorkouts: json['total_workouts'] ?? 0,
    );
  }

  // Method untuk grouping workout berdasarkan kategori
  Map<String, List<Workout>> getGroupedByCategory() {
    Map<String, List<Workout>> grouped = {
      'With Equipment': [],
      'Without Equipment': [],
    };

    for (var workout in workouts) {
      if (workout.equipment.toLowerCase().contains('no equipment') || 
          workout.equipment.toLowerCase().contains('bodyweight') ||
          workout.equipment.isEmpty) {
        grouped['Without Equipment']!.add(workout);
      } else {
        grouped['With Equipment']!.add(workout);
      }
    }

    return grouped;
  }

  // Method untuk grouping workout berdasarkan status
  Map<String, List<Workout>> getGroupedByStatus() {
    Map<String, List<Workout>> grouped = {
      'completed': [],
      'in_progress': [],
      'not_started': [],
    };

    for (var workout in workouts) {
      if (workout.isCompleted) {
        grouped['completed']!.add(workout);
      } else if (workout.isStarted) {
        grouped['in_progress']!.add(workout);
      } else {
        grouped['not_started']!.add(workout);
      }
    }

    return grouped;
  }

  // Method untuk menghitung statistik
  Map<String, int> getStatistics() {
    int completed = 0;
    int inProgress = 0;
    int notStarted = 0;

    for (var workout in workouts) {
      if (workout.isCompleted) {
        completed++;
      } else if (workout.isStarted) {
        inProgress++;
      } else {
        notStarted++;
      }
    }

    return {
      'completed': completed,
      'in_progress': inProgress,
      'not_started': notStarted,
      'total': workouts.length,
    };
  }
}

class WorkoutService {
  // Method utama untuk mengambil data workout hari ini
  static Future<Map<String, dynamic>> getTodayWorkouts() async {
    final token = await SessionManager.getAuthToken();
    
    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login kembali.',
        'data': null,
      };
    }
    
    final url = Uri.parse('$apiConnect/api/workout/today');
    
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['status'] == 'success') {
        final workoutResponse = WorkoutResponse.fromJson(data);
        
        return {
          'success': true,
          'message': data['message'] ?? 'Workout berhasil diambil',
          'data': workoutResponse,
          'rawData': data,
        };
      } else {
        // Jika token tidak valid, clear session
        if (response.statusCode == 401) {
          await SessionManager.clearSession();
        }
        
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal mengambil workout',
          'errorCode': response.statusCode,
          'data': null,
        };
      }
    } on http.ClientException catch (e) {
      return {
        'success': false,
        'message': 'Koneksi internet bermasalah: ${e.message}',
        'data': null,
      };
    } on FormatException catch (e) {
      return {
        'success': false,
        'message': 'Format data tidak valid: ${e.message}',
        'data': null,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan tak terduga: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Method untuk mengambil workout berdasarkan jadwal ID
  static Future<Map<String, dynamic>> getWorkoutByJadwalId(int jadwalId) async {
    final token = await SessionManager.getAuthToken();
    
    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login kembali.',
        'data': null,
      };
    }
    
    final url = Uri.parse('$apiConnect/api/workout/jadwal/$jadwalId');
    
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['status'] == 'success') {
        // Data mungkin berupa single workout atau list
        if (data['data'] is List) {
          List<Workout> workouts = (data['data'] as List)
              .map((item) => Workout.fromJson(item))
              .toList();
          
          return {
            'success': true,
            'message': data['message'] ?? 'Workout berhasil diambil',
            'data': workouts,
            'rawData': data,
          };
        } else {
          Workout workout = Workout.fromJson(data['data']);
          
          return {
            'success': true,
            'message': data['message'] ?? 'Workout berhasil diambil',
            'data': workout,
            'rawData': data,
          };
        }
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal mengambil workout',
          'errorCode': response.statusCode,
          'data': null,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Method untuk mendapatkan workout berdasarkan kategori
  static Future<Map<String, dynamic>> getWorkoutByCategory(String category) async {
    final result = await getTodayWorkouts();
    
    if (!result['success'] || result['data'] == null) {
      return result;
    }
    
    final WorkoutResponse workoutResponse = result['data'];
    final groupedWorkouts = workoutResponse.getGroupedByCategory();
    
    String normalizedCategory = category;
    if (category.toLowerCase().contains('with equipment')) {
      normalizedCategory = 'With Equipment';
    } else if (category.toLowerCase().contains('without equipment') || category.toLowerCase().contains('no equipment')) {
      normalizedCategory = 'Without Equipment';
    }
    
    List<Workout> workouts = groupedWorkouts[normalizedCategory] ?? [];
    
    return {
      'success': true,
      'message': 'Workout kategori $category berhasil diambil',
      'data': workouts,
      'total': workouts.length,
    };
  }

  // Method untuk mendapatkan workout berdasarkan status
  static Future<Map<String, dynamic>> getWorkoutByStatus(String status) async {
    final result = await getTodayWorkouts();
    
    if (!result['success'] || result['data'] == null) {
      return result;
    }
    
    final WorkoutResponse workoutResponse = result['data'];
    final groupedByStatus = workoutResponse.getGroupedByStatus();
    
    String normalizedStatus = status.toLowerCase();
    if (normalizedStatus == 'completed') {
      normalizedStatus = 'completed';
    } else if (normalizedStatus == 'in progress' || normalizedStatus == 'sedang') {
      normalizedStatus = 'in_progress';
    } else {
      normalizedStatus = 'not_started';
    }
    
    List<Workout> workouts = groupedByStatus[normalizedStatus] ?? [];
    
    return {
      'success': true,
      'message': 'Workout status $status berhasil diambil',
      'data': workouts,
      'total': workouts.length,
    };
  }

  // Method untuk refresh token
  static Future<Map<String, dynamic>> refreshToken() async {
    final token = await SessionManager.getAuthToken();
    
    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan',
      };
    }
    
    final url = Uri.parse('$apiConnect/api/refresh-token');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['success'] == true) {
        final newToken = data['data']['token_auth'];
        await SessionManager.setAuthToken(newToken);
        
        return {
          'success': true,
          'message': 'Token berhasil diperbarui',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal memperbarui token',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal memperbarui token: ${e.toString()}',
      };
    }
  }

  // Method untuk menangani error dan retry
  static Future<Map<String, dynamic>> getTodayWorkoutsWithRetry({
    int maxRetries = 3,
    int delayInSeconds = 2,
  }) async {
    for (int i = 0; i < maxRetries; i++) {
      final result = await getTodayWorkouts();
      
      if (result['success'] == true) {
        return result;
      }
      
      // Jika error karena token expired, coba refresh token
      if (result['errorCode'] == 401 && i < maxRetries - 1) {
        await refreshToken();
      }
      
      // Tunggu sebelum retry
      if (i < maxRetries - 1) {
        await Future.delayed(Duration(seconds: delayInSeconds));
      }
    }
    
    return {
      'success': false,
      'message': 'Gagal mengambil workout setelah beberapa percobaan',
      'data': null,
    };
  }
}