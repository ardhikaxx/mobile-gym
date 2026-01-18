import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/service/connect.dart';
import 'package:flutter_application_1/utils/session_manager.dart';

class FeedbackService {
  // Method untuk mengambil feedback pengguna
  static Future<Map<String, dynamic>> getMyFeedback() async {
    final token = await SessionManager.getAuthToken();
    
    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login kembali.',
      };
    }
    
    final url = Uri.parse('$apiConnect/api/feedback/my');
    
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['status'] == 'success') {
        return {
          'success': true,
          'message': data['message'],
          'data': data['data'],
        };
      } else {
        // Jika tidak ada feedback
        if (response.statusCode == 404) {
          return {
            'success': true,
            'message': 'Belum ada feedback',
            'data': null,
          };
        }
        
        // Jika token tidak valid, clear session
        if (response.statusCode == 401) {
          await SessionManager.clearSession();
        }
        
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal mengambil feedback',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan. Periksa koneksi internet Anda.',
      };
    }
  }

  // Method untuk menambah feedback
  static Future<Map<String, dynamic>> addFeedback({
    required int rating,
    required String review,
  }) async {
    final token = await SessionManager.getAuthToken();
    
    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login kembali.',
      };
    }
    
    final url = Uri.parse('$apiConnect/api/feedback');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'rating': rating,
          'review': review,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201 && data['status'] == 'success') {
        return {
          'success': true,
          'message': data['message'],
          'data': data['data'],
        };
      } else {
        // Jika token tidak valid, clear session
        if (response.statusCode == 401) {
          await SessionManager.clearSession();
        }
        
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal menambahkan feedback',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan. Periksa koneksi internet Anda.',
      };
    }
  }

  // Method untuk mengedit feedback
  static Future<Map<String, dynamic>> updateFeedback({
    required int rating,
    required String review,
  }) async {
    final token = await SessionManager.getAuthToken();
    
    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login kembali.',
      };
    }
    
    final url = Uri.parse('$apiConnect/api/feedback/update');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'rating': rating,
          'review': review,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['status'] == 'success') {
        return {
          'success': true,
          'message': data['message'],
          'data': data['data'],
        };
      } else {
        // Jika token tidak valid, clear session
        if (response.statusCode == 401) {
          await SessionManager.clearSession();
        }
        
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal memperbarui feedback',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan. Periksa koneksi internet Anda.',
      };
    }
  }

  // Method untuk menghapus feedback
  static Future<Map<String, dynamic>> deleteFeedback() async {
    final token = await SessionManager.getAuthToken();
    
    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login kembali.',
      };
    }
    
    final url = Uri.parse('$apiConnect/api/feedback');
    
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['status'] == 'success') {
        return {
          'success': true,
          'message': data['message'],
          'data': data['data'],
        };
      } else {
        // Jika token tidak valid, clear session
        if (response.statusCode == 401) {
          await SessionManager.clearSession();
        }
        
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal menghapus feedback',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan. Periksa koneksi internet Anda.',
      };
    }
  }
}