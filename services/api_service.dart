import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://catfact.ninja/fact';

  Future<String> fetchRandomFact() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['fact'];
    } else {
      throw Exception('Gagal mengambil data dari API');
    }
  }
}