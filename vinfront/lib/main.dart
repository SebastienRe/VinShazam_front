// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentification/authentification_manager.dart';
import 'authentification/connexion_form.dart';
import 'authentification/inscription_form.dart';
import 'widgets/background_wine.dart';
import 'authentification/service/authentification_service.dart';

void main() {
  //mettre l adresse ip de ta machine hote : cmd => ipconfig => adresse ipv4
  final authService = AuthService(baseUrl: 'http://172.20.10.12:3000');

  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  MyApp({required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthFormBloc(),
        child: AuthScreen(authService: authService),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  final AuthService authService;

  AuthScreen({required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentification')),
      body: Stack(
        children: [
          // BackgroundWine comme widget
          BackgroundWine(),
          Center(
            child: BlocBuilder<AuthFormBloc, AuthFormState>(
              builder: (context, state) {
                return state.isSignInForm
                    ? SignInForm(authService: authService)
                    : SignUpForm(authService : authService);
              },
            ),
          ),
        ],
      ),
    );
  }
}
