import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _key = 'saved_facts';

  Future<void> saveFact(String fact) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> facts = prefs.getStringList(_key) ?? [];
    if (!facts.contains(fact)) {
      facts.add(fact);
      await prefs.setStringList(_key, facts);
    }
  }

  Future<List<String>> getSavedFacts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}