import 'package:tracker/data/models/user/user_model.dart';
import 'package:tracker/data/repositories/auth/auth_impl.dart';

class FirebaseAuthImpl extends AuthRepository {
  @override
  Future<AppUser?> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> signUpWithEmailAndPassword(String email, String password) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
