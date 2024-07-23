import 'package:cloud_firestore/cloud_firestore.dart';
import '/constants/index.dart';
import '/model/user_model.dart';

class FirebaseProfileService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> createProfile(
      String uid, Map<String, dynamic> data) async {
    await _firestore
        .collection(FirebaseConst.users)
        .doc(uid)
        .set(data, SetOptions(merge: true));
  }

  static Future<void> updateProfile(
      String uid, Map<String, dynamic> data) async {
    await _firestore.collection(FirebaseConst.users).doc(uid).update(data);
  }

  static Future<AuthUser?> getProfile(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection(FirebaseConst.users).doc(uid).get();
    if (snapshot.exists) return AuthUser.fromFirestore(snapshot);
    return null;
  }

  static Future<void> deleteProfile(String uid) async {
    await _firestore.collection(FirebaseConst.users).doc(uid).delete();
  }

  static Stream<AuthUser?> profileStream(String uid) {
    return _firestore.collection(FirebaseConst.users).doc(uid).snapshots().map(
        (snapshot) =>
            snapshot.exists ? AuthUser.fromFirestore(snapshot) : null);
  }
}
