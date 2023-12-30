// profil.dart
import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  final String nom;
  final String prenom;

  Profil({required this.nom, required this.prenom});

  @override
  Widget build(BuildContext context) {
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
                Text('Bonjour $prenom $nom !', style: TextStyle(color: Colors.white)),
                ElevatedButton(
                  onPressed: () {
                    // Ajoutez ici la logique pour scanner un vin
                  },
                  child: Text('Scanner un vin'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Ajoutez ici la logique pour se déconnecter
                    // Cela peut inclure le nettoyage de l'état de connexion, la déconnexion de l'utilisateur, etc.
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
