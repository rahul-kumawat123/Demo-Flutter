import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user/user_model.dart';

class AuthLocalStorage {
  static const String _usersKey = 'registered_users';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _currentUserKey = 'current_user';

  // Encryption key (32 bytes for AES-256)
  static final _key = Key.fromUtf8('demo_flutter_secret_key_32bytes!');
  static final _iv = IV.fromLength(16);
  static final _encrypter = Encrypter(AES(_key));

  static final List<Map<String, String>> _mockUsers = [
    {'email': 'test@demo.com', 'password': 'password123'},
    {'email': 'admin@demo.com', 'password': 'admin12345'},
    {'email': 'user@demo.com', 'password': 'user12345'},
  ];

  static String encryptPassword(String password) {
    return _encrypter.encrypt(password, iv: _iv).base64;
  }

  static String decryptPassword(String encryptedPassword) {
    return _encrypter.decrypt64(encryptedPassword, iv: _iv);
  }

  static bool _isMockUser(String email, String password) {
    return _mockUsers.any(
      (user) => user['email'] == email && user['password'] == password,
    );
  }

  // Save user to SharedPreferences
  static Future<bool> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    final existingUsersJson = prefs.getString(_usersKey);
    List<Map<String, dynamic>> users = [];

    if (existingUsersJson != null) {
      users = List<Map<String, dynamic>>.from(jsonDecode(existingUsersJson));
    }

    if (users.any((u) => u['email'] == user.email)) {
      return false; // User already exists
    }

    // Encrypt password before saving
    final userWithEncryptedPassword = user.copyWith(
      password: encryptPassword(user.password),
    );

    users.add(userWithEncryptedPassword.toJson());
    await prefs.setString(_usersKey, jsonEncode(users));
    return true;
  }

  // Authenticate user (check mock users + registered users)
  static Future<UserModel?> authenticateUser(
    String email,
    String password,
  ) async {
    if (_isMockUser(email, password)) {
      return UserModel(
        name: email.split('@').first,
        email: email,
        password: '', // Don't expose password
        dob: DateTime(1990, 1, 1),
        gender: 'Other',
      );
    }

    // Then check registered users
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);

    if (usersJson == null) return null;

    final users = List<Map<String, dynamic>>.from(jsonDecode(usersJson));

    for (final userJson in users) {
      if (userJson['email'] == email) {
        try {
          final decryptedPassword = decryptPassword(userJson['password']);
          if (decryptedPassword == password) {
            return UserModel.fromJson({
              ...userJson,
              'password': '', // Don't expose password
            });
          }
        } catch (_) {
          return null;
        }
      }
    }

    return null;
  }

  // Set logged in state
  static Future<void> setLoggedIn(bool value, {UserModel? user}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);

    if (value && user != null) {
      await prefs.setString(_currentUserKey, jsonEncode(user.toJson()));
    } else if (!value) {
      await prefs.remove(_currentUserKey);
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get current user
  static Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_currentUserKey);

    if (userJson == null) return null;

    return UserModel.fromJson(jsonDecode(userJson));
  }

  // Check if email exists
  static Future<bool> emailExists(String email) async {
    // Check mock users
    if (_mockUsers.any((user) => user['email'] == email)) {
      return true;
    }

    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);

    if (usersJson == null) return false;

    final users = List<Map<String, dynamic>>.from(jsonDecode(usersJson));
    return users.any((u) => u['email'] == email);
  }
}
