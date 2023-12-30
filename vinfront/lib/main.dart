// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentification/authentification_manager.dart';
import 'authentification/connexion_form.dart';
import 'authentification/inscription_form.dart';
import 'widgets/background_wine.dart'; // Importez le fichier

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthFormBloc(),
        child: AuthScreen(),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentification')),
      body: Stack(
        children: [
          // BackgroundWine comme widget
          BackgroundWine(),
          BlocBuilder<AuthFormBloc, AuthFormState>(
            builder: (context, state) {
              return state.isSignInForm ? SignInForm() : SignUpForm();
            },
          ),
        ],
      ),
    );
  }
}
