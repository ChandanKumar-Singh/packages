part of 'provider.dart';

class EmailAuth extends SocialAuthProvider {
  final String email;
  final String password;

  EmailAuth(this.email, this.password);

  @override
  Future<AuthResult> login() async {
    try {
      var res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (res.user != null) {
        bool isNewUser = res.additionalUserInfo?.isNewUser ?? false;
        var authUser = AuthUser(
          primaryId: res.user!.uid,
          uid: res.user!.uid,
          email: res.user!.email,
          name: res.user!.displayName,
          photoUrl: res.user!.photoURL,
          phoneNumber: res.user!.phoneNumber,
          createdAt: res.user!.metadata.creationTime?.toLocal().toString(),
          authProviderName: 'Email',
        );

        return AuthResult(true,
            isNewUser ? 'Welcome to uLearning 🙌' : "Welcome back", authUser);
      }
    } on FirebaseException catch (e) {
      logg('Login with email failed', error: e, name: 'EmailAuth');
      return AuthResult(false,
          FirebaseRepository.instance.getFirebaseExceptionMessage(e), null);
    } catch (e) {
      logg('Login with email failed', error: e, name: 'EmailAuth');
    }
    return AuthResult(false, 'Login with email failed', null);
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
    return AuthResult(true, 'Loggged out successfully', null);
  }

  @override
  String get providerName => 'email';
}
