// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vinfront/authentification/SauvegardeUser.dart';
import 'authentification/authentification_manager.dart';
import 'authentification/connexion_form.dart';
import 'authentification/inscription_form.dart';
import 'widgets/background_wine.dart';
import 'authentification/service/authentification_service.dart';
import 'vin/service/VinService.dart';

void main() {
  //mettre l adresse ip de ta machine hote : cmd => ipconfig => adresse ipv4
  final url = 'http://192.168.154.42:3000';
  final authService = AuthService(baseUrl: url);
  final vinService = VinService(baseUrl: url);

  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(authService: authService, vinService: vinService)));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final VinService vinService;

  MyApp({required this.authService, required this.vinService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthFormBloc(),
        child: AuthScreen(authService: authService, vinService: vinService),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  final AuthService authService;
  final VinService vinService;

  AuthScreen({required this.authService, required this.vinService});

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
                    ? SignInForm(
                        authService: authService, vinService: vinService)
                    : SignUpForm(authService: authService);
              },
            ),
          ),
        ],
      ),
    );
  }
}
