  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'connexion_exception.dart';
  class AuthService {
    final String baseUrl;

    AuthService({required this.baseUrl});

    Future<Map<String, dynamic>> loginUser(String email, String password) async {
      final url = Uri.parse('$baseUrl/users/connexion');
      print("url : " + url.toString());
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'identifiant': email,
          'motDePasse': password,
        }),
      );

      if (response.statusCode == 200) {
        // Si la requête a réussi, décoder la réponse JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        return data;
      } else {
        // Si la requête a échoué, imprimer le code d'erreur
        print('Erreur de connexion: ${response.statusCode}');
        // Vous pouvez retourner un objet d'erreur ou lancer une exception ici
        throw SnackBarException('Mot de passe ou email incorrecte');
      }
    }
    Future<List<Map<String, dynamic>>> getUsers() async {
      final url = Uri.parse('$baseUrl/users');
      print("url : " + url.toString());
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Si la requête a réussi, décoder la réponse JSON
        final List<dynamic> userList = jsonDecode(response.body);
        final List<Map<String, dynamic>> users = List.castFrom(userList);
        print(users);
        return users;
      } else {
        // Si la requête a échoué, imprimer le code d'erreur
        print('Erreur lors de la récupération des utilisateurs: ${response.statusCode}');
        // Vous pouvez retourner un objet d'erreur ou lancer une exception ici
        throw Exception('Erreur lors de la récupération des utilisateurs');
      }
    }
    Future<Map<String, dynamic>> inscrireUser(String nom, String prenom, String email, String password) async {
      final url = Uri.parse('$baseUrl/users/inscription');
      print("url : " + url.toString());
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nom': nom,
          'prenom': prenom,
          'identifiant': email,
          'motDePasse': password,
        }),
      );

      if (response.statusCode == 200) {
        // Si l'inscription a réussi, décoder la réponse JSON
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        // Si la requête a échoué, imprimer le code d'erreur
        print("Erreur lors de l'inscription: ${response.statusCode}");
        // Vous pouvez retourner un objet d'erreur ou lancer une exception ici
        throw Exception("Erreur lors de l'inscription");
        }
        }

  }
