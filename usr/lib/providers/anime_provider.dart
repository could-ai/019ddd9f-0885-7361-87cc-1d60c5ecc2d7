import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/anime.dart';
import '../services/api_service.dart';

class AnimeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Anime> _topAnime = [];
  List<Anime> _searchData = [];
  List<Anime> _favorites = [];
  bool _isLoading = false;
  String _error = '';

  List<Anime> get topAnime => _topAnime;
  List<Anime> get searchData => _searchData;
  List<Anime> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get error => _error;

  AnimeProvider() {
    _loadFavorites();
    fetchTopAnime();
  }

  Future<void> fetchTopAnime() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _topAnime = await _apiService.fetchTopAnime();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchAnime(String query) async {
    if (query.isEmpty) {
      _searchData = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _searchData = await _apiService.searchAnime(query);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(Anime anime) {
    return _favorites.any((fav) => fav.id == anime.id);
  }

  Future<void> toggleFavorite(Anime anime) async {
    if (isFavorite(anime)) {
      _favorites.removeWhere((fav) => fav.id == anime.id);
    } else {
      _favorites.add(anime);
    }
    notifyListeners();
    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      _favorites.map((anime) => anime.toJson()).toList(),
    );
    await prefs.setString('favorites', encodedData);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('favorites');
    
    if (encodedData != null) {
      final List<dynamic> decodedData = json.decode(encodedData);
      _favorites = decodedData.map((json) => Anime.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
