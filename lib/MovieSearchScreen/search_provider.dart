import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  String _searchText = "";
  List<dynamic> _movies = [];
  bool _isLoading = false;

  String get searchText => _searchText;
  List<dynamic> get movies => _movies;
  bool get isLoading => _isLoading;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<void> searchMovies() async {
    if (_searchText.isEmpty) return;

    final url = 'http://www.omdbapi.com/?s=$_searchText&apikey=566c4800';
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == "True") {
          _movies = data['Search'] ?? [];
        } else {
          _movies = [];
        }
      } else {
        _movies = [];
      }
    } catch (e) {
      _movies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTrendingMovies() async {
    const url =
        'http://www.omdbapi.com/?s=marvel&apikey=566c4800'; // Example trending query
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == "True") {
          _movies = data['Search'] ?? [];
        } else {
          _movies = [];
        }
      } else {
        _movies = [];
      }
    } catch (e) {
      _movies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
