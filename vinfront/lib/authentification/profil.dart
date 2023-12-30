// profil.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinfront/authentification/SauvegardeUser.dart';
import 'package:vinfront/vin/service/VinService.dart';
import '../vin/camera.dart';

class Profil extends StatelessWidget {
  var prenom;
  var nom;
  final VinService vinService;

  Profil({required this.vinService});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      body: Stack(
        children: [
          // Image de vin en arrière-plan
          Image.network(
            'https://cdn.bioalaune.com/img/article/thumb/900x500/37182-rouge-blanc-contient-reellement-bouteille-vin.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bonjour ${user['prenom']} ${user['nom']} !',
                    style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CameraPage(vinService: vinService)),
                    );
                  },
                  child: Text('Scanner un vin'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Ajoutez ici la logique pour se déconnecter
                    // Cela peut inclure le nettoyage de l'état de connexion, la déconnexion de l'utilisateur, etc.
                    Provider.of<UserProvider>(context, listen: false).setUser(
                        Map<String,
                            dynamic>()); // Remettre à zéro l'utilisateur
                    // Ensuite, revenez à l'écran de connexion
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  },
                  child: Text('Se déconnecter'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
