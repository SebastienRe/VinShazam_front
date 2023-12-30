// sign_in_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentification_manager.dart';
import 'service/authentification_service.dart';
import 'service/connexion_exception.dart';
import 'profil.dart';

class SignInForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService;

  SignInForm({required this.authService});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3), // Fond semi-transparent
      padding: const EdgeInsets.all(16.0),
      child: Theme(
        data: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Récupérer les valeurs des champs de texte
                try {
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  // Imprimer les valeurs dans la console
                  print('Email: $email, Mot de passe: $password');
                  Map<String, dynamic> result = {
                    'nom': 'Doe',
                    'prenom': 'John'
                  };
                  // await authService.loginUser(email, password);

                  // Gérer la réponse de l'API ici
                  print('Réponse de l\'API: $result');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Connexion réussie !'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profil(
                        nom: result['nom'],
                        prenom: result['prenom'],
                      ),
                    ),
                  );
                } catch (e) {
                  // Gérer les exceptions, y compris la SnackBarException
                  if (e is SnackBarException) {
                    // Afficher un SnackBar avec le message d'erreur
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.message),
                    ));
                  } else {
                    // Gérer d'autres exceptions ici
                    print('Erreur inattendue: $e');
                  }
                }
                // Logique de connexion
              },
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                BlocProvider.of<AuthFormBloc>(context)
                    .add(AuthFormEvent.switchToSignUp);
              },
              child: const Text(
                "Vous n'avez pas de compte ? Inscrivez-vous",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
