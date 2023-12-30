// auth_form_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthFormEvent { signIn, signUp, switchToSignUp }

class AuthFormState {
  final bool isSignInForm;

  AuthFormState(this.isSignInForm);
}

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  AuthFormBloc() : super(AuthFormState(true)) {
    on<AuthFormEvent>((event, emit) {
      if (event == AuthFormEvent.signIn) {
        emit(AuthFormState(true));
      } else if (event == AuthFormEvent.signUp) {
        emit(AuthFormState(false));
      } else if (event == AuthFormEvent.switchToSignUp) {
        emit(AuthFormState(!state.isSignInForm));
      }
    });
  }
}

