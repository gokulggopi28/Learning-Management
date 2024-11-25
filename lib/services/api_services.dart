import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const _baseUrl = "https://trogon.info/interview/php/api/";

  static Future<List<dynamic>> fetchSubjects() async {
    final response = await http.get(Uri.parse('${_baseUrl}subjects.php'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load subjects');
  }

  static Future<List<dynamic>> fetchModules(String subjectId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}modules.php?subject_id=$subjectId'),
      );


      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load modules: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<dynamic>> fetchVideos(String moduleId) async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}videos.php?module_id=$moduleId'),
      );


      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load videos: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
