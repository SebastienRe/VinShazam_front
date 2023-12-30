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
}
