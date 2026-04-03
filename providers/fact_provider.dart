import 'package:flutter/material.dart';
import '../locator.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class FactProvider extends ChangeNotifier {
  final ApiService _apiService = locator<ApiService>();
  final StorageService _storageService = locator<StorageService>();

  String _currentFact = "Tekan tombol untuk mengambil fakta";
  bool _isLoading = false;
  List<String> _savedFacts = [];

  String get currentFact => _currentFact;
  bool get isLoading => _isLoading;
  List<String> get savedFacts => _savedFacts;

  FactProvider() {
    loadSavedFacts();
  }

  Future<void> getRandomFact() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentFact = await _apiService.fetchRandomFact();
    } catch (e) {
      _currentFact = "Terjadi kesalahan koneksi.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveCurrentFact() async {
    if (_currentFact.isNotEmpty) {
      await _storageService.saveFact(_currentFact);
      await loadSavedFacts();
    }
  }

  Future<void> loadSavedFacts() async {
    _savedFacts = await _storageService.getSavedFacts();
    notifyListeners();
  }
}