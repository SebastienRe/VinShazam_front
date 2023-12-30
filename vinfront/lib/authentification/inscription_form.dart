// sign_up_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentification_manager.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3), // Fond semi-transparent
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _nomController,
            decoration: InputDecoration(
              labelText: 'Nom',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _prenomController,
            decoration: InputDecoration(
              labelText: 'Prénom',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Mot de passe',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            obscureText: true,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Récupérer les valeurs des champs de texte
              String email = _emailController.text;
              String password = _passwordController.text;
              String nom = _nomController.text;
              String prenom = _prenomController.text;

              // Imprimer les valeurs dans la console
              print(
                  'Nom: $nom, Prénom: $prenom, Email: $email, Mot de passe: $password');

              // Logique d'inscription
            },
            child: Text("S'inscrire"), // Couleur du texte par défaut
          ),
          SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthFormBloc>(context)
                  .add(AuthFormEvent.switchToSignUp);
            },
            child: Text(
              "Vous avez déjà un compte ? Connectez-vous",
              style: TextStyle(color: Colors.white), // Couleur du texte
            ),
          ),
        ],
      ),
    );
  }
}
