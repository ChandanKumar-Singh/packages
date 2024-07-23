import 'package:ext_plus/ext_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../data/models/index.dart';
import '../../../../data/repositories/index.dart';

part 'google.dart';
part 'email.dart';
part 'facebook.dart';
part 'apple.dart';

abstract class AuthProviderInterface {
  Future<AuthResult> login();

  Future<AuthResult> loggout();

  Future<AuthResult> forgotPassword();

  Future<AuthResult> changePassword();

  String get providerName;
}

abstract class SocialAuthProvider extends AuthProviderInterface {
  @override
  Future<AuthResult> login();

  @override
  Future<AuthResult> loggout();

  @override
  Future<AuthResult> forgotPassword();

  @override
  Future<AuthResult> changePassword();
}

mixin SocialAuthLoggging on AuthProviderInterface {
  @override
  Future<AuthResult> login() async {
    logg('Starting loggin process', name: runtimeType);
    final result = await super.login();
    logg('Loggin process completed', name: runtimeType);
    return result;
  }

  @override
  Future<AuthResult> loggout() async {
    logg('Starting loggout process', name: runtimeType);
    final result = await super.loggout();
    logg('Loggout process completed', name: runtimeType);
    return result;
  }

  @override
  Future<AuthResult> forgotPassword() async {
    logg('Starting forgotPassword process', name: runtimeType);
    final result = await super.forgotPassword();
    logg('ForgotPassword process completed', name: runtimeType);
    return result;
  }

  @override
  Future<AuthResult> changePassword() async {
    logg('Starting changePassword process', name: runtimeType);
    final result = await super.changePassword();
    logg('ChangePassword process completed', name: runtimeType);
    return result;
  }
}

class AuthResult {
  final bool success;
  final String? message;
  final AuthUser? user;

  AuthResult.success(this.user, [this.message]) : success = true;
  AuthResult.failure([this.message, this.user]) : success = false;

  AuthResult(this.success, this.message, this.user);

  @override
  String toString() {
    return 'SocialAuthResult{success: $success, message: $message, user: ${user?.toJson()}}';
  }
}

/*
class SocialUser {
  final String primaryId;
  final String uid;
  final String? email;
  final String? name;
  final String? photoUrl;
  final String? phoneNumber;
  final String? authProviderName;

  SocialUser({
    required this.primaryId,
    required this.uid,
    this.email,
    this.name,
    this.photoUrl,
    this.phoneNumber,
    this.authProviderName,
  });

  SocialUser copyWith({
    String? primaryId,
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    String? phoneNumber,
    String? authProviderName,
  }) {
    return SocialUser(
      primaryId: primaryId ?? this.primaryId,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authProviderName: authProviderName ?? this.authProviderName,
    );
  }

  SocialUser.fromJson(Map<String, dynamic> json)
      : primaryId = json['primaryId'],
        uid = json['uid'],
        email = json['email'],
        name = json['name'],
        photoUrl = json['photoUrl'],
        phoneNumber = json['phoneNumber'],
        authProviderName = json['authProviderName'];

  Map<String, dynamic> toJson() {
    return {
      'primaryId': primaryId,
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'authProviderName': authProviderName
    };
  }
}

*/
