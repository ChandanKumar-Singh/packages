import 'package:ext_plus/ext_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SocialAuth {
  Future<AuthResult> login();

  Future<AuthResult> loggout();

  Future<AuthResult> forgotPassword();

  Future<AuthResult> changePassword();
}

mixin SocialAuthLoggging on SocialAuth {
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
  final String message;
  final SocialUser? user;

  AuthResult.success(this.user, [this.message = '']) : success = true;
  AuthResult.failure([this.message = '', this.user]) : success = false;

  AuthResult({required this.success, required this.message, this.user});

  @override
  String toString() {
    return 'SocialAuthResult{success: $success, message: $message, user: ${user?.toJson()}}';
  }
}

class SocialUser {
  final String primaryId;
  final String uid;
  final String? email;
  final String? name;
  final String? photoUrl;
  final String? phoneNumber;

  SocialUser({
    required this.primaryId,
    required this.uid,
    this.email,
    this.name,
    this.photoUrl,
    this.phoneNumber,
  });

  SocialUser copyWith({
    String? primaryId,
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    String? phoneNumber,
  }) {
    return SocialUser(
      primaryId: primaryId ?? this.primaryId,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  SocialUser.fromJson(Map<String, dynamic> json)
      : primaryId = json['primaryId'],
        uid = json['uid'],
        email = json['email'],
        name = json['name'],
        photoUrl = json['photoUrl'],
        phoneNumber = json['phoneNumber'];

  Map<String, dynamic> toJson() {
    return {
      'primaryId': primaryId,
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
    };
  }
}

class GoogleAuth extends SocialAuth {
  @override
  Future<AuthResult> login() async {
    try {
      /// Trigger the Google Sign In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return AuthResult.failure('Google Sign In failed');
      }

      // Get the Google Sign In Authentication
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      /// Create a new credential
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      /// Sign in to Firebase with the Google Auth Credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);

      /// Get the user
      final User? user = userCredential.user;

      /// Return the user
      return AuthResult.success(
        SocialUser(
          primaryId: googleUser.id,
          uid: user!.uid,
          email: user.email,
          name: user.displayName,
          photoUrl: user.photoURL,
          phoneNumber: user.phoneNumber,
        ),
        'Google Sign In successful',
      );
    } catch (e, st) {
      logg('Google Sign In failed',
          name: runtimeType, error: e, stackTrace: st);
      return AuthResult.failure('Google Sign In failed');
    }
  }

  @override
  Future<AuthResult> changePassword() {
    throw UnimplementedError();
  }

  @override
  Future<AuthResult> forgotPassword() {
    throw UnimplementedError();
  }

  @override
  Future<AuthResult> loggout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return AuthResult(
      success: true,
      message: 'Loggged out successfully',
    );
  }
}

class EmailAuth extends SocialAuth {
  final String email;
  final String password;

  EmailAuth(this.email, this.password);

  @override
  Future<AuthResult> login() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;

      return AuthResult.success(
        SocialUser(
          primaryId: user!.email.validate(),
          uid: user.uid,
          email: user.email,
          name: user.displayName,
          photoUrl: user.photoURL,
          phoneNumber: user.phoneNumber,
        ),
        'Email Sign In successful',
      );
    } catch (e, st) {
      logg('Email Sign In failed', name: runtimeType, error: e, stackTrace: st);
      return AuthResult.failure('Email Sign In failed');
    }
  }

  @override
  Future<AuthResult> changePassword() {
    throw UnimplementedError();
  }

  @override
  Future<AuthResult> forgotPassword() {
    throw UnimplementedError();
  }

  @override
  Future<AuthResult> loggout() async {
    await FirebaseAuth.instance.signOut();
    return AuthResult(
      success: true,
      message: 'Loggged out successfully',
    );
  }
}
