// sign_up_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentification_manager.dart';
import 'service/authentification_service.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final AuthService authService;

  SignUpForm({required this.authService});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
              style: TextStyle(color: Colors.white, fontSize: 18.0),
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
              style: TextStyle(color: Colors.white, fontSize: 18.0),
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
              style: TextStyle(color: Colors.white, fontSize: 18.0),
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
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Récupérer les valeurs des champs de texte
                String email = _emailController.text;
                String password = _passwordController.text;
                String nom = _nomController.text;
                String prenom = _prenomController.text;

                // Imprimer les valeurs dans la console
                print(
                    'Nom: $nom, Prénom: $prenom, Email: $email, Mot de passe: $password');

                // Appel WS
                Map<String, dynamic> result = await authService.inscrireUser(
                  nom,
                  prenom,
                  email,
                  password,
                );

                print('Réponse de l\'API: $result');

                // Afficher la Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Inscription réussie !'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // Rediriger vers le formulaire de connexion après un délai
                Future.delayed(Duration(seconds: 2), () {
                  BlocProvider.of<AuthFormBloc>(context)
                      .add(AuthFormEvent.switchToSignUp);
                });
              },
              child: Text("S'inscrire"),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                BlocProvider.of<AuthFormBloc>(context)
                    .add(AuthFormEvent.switchToSignUp);
              },
              child: Text(
                "Vous avez déjà un compte ? Connectez-vous",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
