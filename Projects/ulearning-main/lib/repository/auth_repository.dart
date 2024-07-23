import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '/blocs/auth/providers/providers.dart';
import '/model/auth_result.dart';
import '/services/auth_service.dart';
import '/services/firebase_profile_service.dart';
import '/utils/extentions/index.dart';

import '../model/user_model.dart';

enum AuthProvider { google, facebook, apple, email }

class AuthRepository {
  Future<(bool, AuthUser?, String?)> login(AuthProviderInterface provider,
      {String? email, String? password}) async {
    AuthResult result = await provider.login();
    if (result.success) {
      await FirebaseProfileService.updateProfile(
          result.user!.uid.validate(), result.user!.toMap());
    }
    return (result.success, result.user, result.message);
  }

  Future<(bool, AuthUser?, String?)> register(EmailAuth provider,
      {String? email, String? password}) async {
    AuthResult result = await provider.register();
    if (result.success) {
      await FirebaseProfileService.createProfile(
          result.user!.uid.validate(), result.user!.toMap());
    }
    return (result.success, result.user, result.message);
  }

  Future<(bool, AuthUser?, String?)> logout(
      AuthProviderInterface provider) async {
    AuthResult result = await provider.loggout();
    if (result.success) {
      await FirebaseAuth.instance.signOut();
      await AuthService.instance.clearAuthSetup();
    }
    return (result.success, result.user, result.message);
  }
}
