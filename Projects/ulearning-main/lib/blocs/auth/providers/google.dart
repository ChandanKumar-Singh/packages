import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../model/index.dart';
import '../../../utils/extentions/index.dart';
import 'providers.dart';

class GoogleAuth extends SocialAuthProvider {
  @override
  Future<AuthResult> login() async {
    try {
      await loggout();
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return AuthResult(success: false, message: 'Google Sign In failed');
      }

      // Get the Google Sign In Authentication
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google Auth Credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);

      // Get the user
      final User? user = userCredential.user;
      AuthUser? authUser = AuthUser(
        primaryId: googleUser.id,
        uid: user!.uid,
        email: user.email,
        name: user.displayName,
        photoUrl: user.photoURL,
        phoneNumber: user.phoneNumber,
        emailVerified: user.emailVerified,
        authProviderName: 'Google',
        createdAt: user.metadata.creationTime?.toLocal().toString(),
      );
      // Return the user
      return AuthResult(
        success: true,
        message: 'Google Sign In successful',
        user: authUser,
      );
    } on UnhandledException catch (e) {
      return AuthResult(success: false, message: 'Google Sign In failed $e');
    } catch (e) {
      return AuthResult(success: false, message: 'Google Sign In failed $e');
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
    await GoogleSignIn().signOut();
    return AuthResult.success();
  }

  @override
  String get providerName => 'Google';
}
