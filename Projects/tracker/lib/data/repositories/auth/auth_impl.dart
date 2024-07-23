import '../../models/index.dart';

abstract class AuthRepository {
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password);
  Future<AuthUser?> signUpWithEmailAndPassword(String email, String password);

  Future<AuthUser?> signInWithGoogle();

  Future<AuthUser?> getCurrentUser();
  Future<bool> isSignedIn();
  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
