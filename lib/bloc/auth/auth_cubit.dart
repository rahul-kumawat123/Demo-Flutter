import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/auth_local_storage.dart';
import '../../models/user/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.initial());

  // Check if user is already logged in
  Future<void> checkAuthStatus() async {
    emit(const AuthState.loading());

    final isLoggedIn = await AuthLocalStorage.isLoggedIn();

    if (isLoggedIn) {
      final user = await AuthLocalStorage.getCurrentUser();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  // Login with email and password
  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());

    final user = await AuthLocalStorage.authenticateUser(email, password);

    if (user != null) {
      await AuthLocalStorage.setLoggedIn(true, user: user);
      emit(AuthState.authenticated(user));
    } else {
      emit(const AuthState.error('Invalid email or password'));
    }
  }

  // Sign up new user
  Future<void> signUp(UserModel user) async {
    emit(const AuthState.loading());

    final emailExists = await AuthLocalStorage.emailExists(user.email);
    if (emailExists) {
      emit(const AuthState.error('Email already registered'));
      return;
    }

    final success = await AuthLocalStorage.saveUser(user);

    if (success) {
      emit(const AuthState.signupSuccess());
    } else {
      emit(const AuthState.error('Failed to register user'));
    }
  }

  // Logout
  Future<void> logout() async {
    emit(const AuthState.loading());
    await AuthLocalStorage.setLoggedIn(false);
    emit(const AuthState.unauthenticated());
  }

  // Reset to initial state (for navigation purposes)
  void resetState() {
    emit(const AuthState.initial());
  }
}

