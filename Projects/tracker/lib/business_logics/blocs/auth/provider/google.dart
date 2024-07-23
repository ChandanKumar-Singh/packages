part of 'provider.dart';

class GoogleAuth extends SocialAuthProvider {
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

      AuthUser? authUser = AuthUser(
        primaryId: googleUser.id,
        uid: user!.uid,
        email: user.email,
        name: user.displayName,
        photoUrl: user.photoURL,
        phoneNumber: user.phoneNumber,
        emailVerified: user.emailVerified,
        authProviderName: providerName,
        createdAt: user.metadata.creationTime?.toLocal().toString(),
      );
      // Return the user
      return AuthResult(true, 'Google Sign In successful', authUser);
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
    await GoogleSignIn().signOut();
    return AuthResult(true, 'Loggged out successfully', null);
  }

  @override
  String get providerName => 'google';
}
