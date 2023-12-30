import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class VinService {
  final String baseUrl;

  VinService({required this.baseUrl});

  Future<Map<String, dynamic>?> sendImageToServer(File image) async {
    final url = Uri.parse('$baseUrl/vins/searchVin');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return jsonDecode(body);
    }
    return null;
  }

  Future<Map<String, dynamic>?> updateWineDetails(
      Map<String, dynamic> wineDetails) async {
    ///updateVin/:id
    final url = Uri.parse('$baseUrl/vins/updateVin/${wineDetails['_id']}');
    final response = await http.put(url, body: wineDetails);

    if (response.statusCode == 200) {
      // Si la requête a réussi, décoder la réponse JSON
      return jsonDecode(response.body);
    } else {
      // Si la requête a échoué, imprimer le code d'erreur
      print('Erreur de connexion: ${response.statusCode}');
      throw Exception('Erreur de connexion');
    }
  }
}
