import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class ApiService {
  static const String baseUrl = 'https://api.jikan.moe/v4';

  Future<List<Anime>> fetchTopAnime({int page = 1}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/top/anime?page=$page'));
      
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final List<dynamic> data = decodedData['data'];
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load anime');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<List<Anime>> searchAnime(String query, {int page = 1}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime?q=$query&page=$page'));
      
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final List<dynamic> data = decodedData['data'];
        return data.map((json) => Anime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search anime');
      }
    } catch (e) {
      throw Exception('Error searching anime: $e');
    }
  }
}
