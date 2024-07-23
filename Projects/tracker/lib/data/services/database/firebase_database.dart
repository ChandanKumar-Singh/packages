import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ext_plus/ext_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/data/models/index.dart';

import 'index.dart';

extension on DocumentSnapshot<dynamic> {
  bool get valid => exists && data() != null;
}

class FirebaseDb implements Database {
  FirebaseDb._();
  static final FirebaseDb instance = FirebaseDb._();
  factory FirebaseDb() => instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const String userCollectionName = 'users';

  CollectionReference get userCollection =>
      firestore.collection(userCollectionName);
  DocumentReference userDoc(String id) => userCollection.doc(id);

  @override
  Future<AuthUser?> getUserData(String id) async {
    var data = await userDoc(id).get();
    if (!data.valid) return null;
    return AuthUser.fromJson(data.data() as MapType);
  }

  @override
  Future<void> setUserData(String id, MapType data, {bool merge = true}) async {
    await userDoc(id).set(data, SetOptions(merge: merge)).then((value) => true);
  }
}
