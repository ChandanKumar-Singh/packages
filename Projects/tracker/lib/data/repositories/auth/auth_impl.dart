import '../../models/index.dart';

abstract class AuthRepository {
  Future<AppUser?> signInWithEmailAndPassword(String email, String password);
  Future<AppUser?> signUpWithEmailAndPassword(String email, String password);

  Future<AppUser?> signInWithGoogle();

  Future<AppUser?> getCurrentUser();
  Future<bool> isSignedIn();
  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
