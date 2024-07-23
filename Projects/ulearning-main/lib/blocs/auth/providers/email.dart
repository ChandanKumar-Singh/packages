import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/index.dart';
import '../../../repository/firebase_repository.dart';
import '../../../utils/index.dart';
import 'providers.dart';

class EmailAuth extends AuthProviderInterface {
  String email;
  String password;
  EmailAuth({required this.email, required this.password});
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

        return AuthResult(
          success: true,
          user: authUser,
          message: isNewUser ? 'Welcome to uLearning 🙌' : "Welcome back",
        );
      }
    } on FirebaseException catch (e) {
      logg('Login with email failed', error: e, name: 'EmailAuth');
      return AuthResult(
          success: false,
          message: FirebaseRepository.instance.getFirebaseExceptionMessage(e));
    } catch (e) {
      logg('Login with email failed', error: e, name: 'EmailAuth');
    }
    return AuthResult(success: false, message: 'Something went wrong');
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
  Future<AuthResult> loggout() {
    throw UnimplementedError();
  }

  Future<AuthResult> register() async {
    try {
      var res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
        await FirebaseRepository.instance.setData(
          collectionPath: 'users',
          data: authUser.toMap(),
          documentId: authUser.uid,
        );
        return AuthResult(
          success: true,
          user: authUser,
          message: isNewUser ? 'Welcome to uLearning 🙌' : "Welcome back",
        );
      }
    } on FirebaseAuthException catch (e) {
      logg('Login with email failed', error: e, name: 'EmailAuth');
      return AuthResult(
          success: false,
          message: FirebaseRepository.instance.getFirebaseExceptionMessage(e));
    } catch (e) {
      logg('Login with email failed', error: e, name: 'EmailAuth');
    }
    return AuthResult(success: false, message: 'Something went wrong');
  }

  @override
  String get providerName => 'Email';
}
