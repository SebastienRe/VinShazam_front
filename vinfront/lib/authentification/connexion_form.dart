// sign_in_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentification_manager.dart';

class SignInForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3), // Fond semi-transparent
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

              // Imprimer les valeurs dans la console
              print('Email: $email, Mot de passe: $password');

              // Logique de connexion
            },
            child: Text('Se connecter'), // Couleur du texte par défaut
          ),
          SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthFormBloc>(context)
                  .add(AuthFormEvent.switchToSignUp);
            },
            child: Text(
              "Vous n'avez pas de compte ? Inscrivez-vous",
              style: TextStyle(color: Colors.white), // Couleur du texte
            ),
          ),
        ],
      ),
    );
  }
}
