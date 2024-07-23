import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/utils/extentions/index.dart';
import '/utils/index.dart';

class FirebaseRepository {
  final String tag = 'FirebaseRepository';
  FirebaseRepository._privateConstructor();
  static final FirebaseRepository instance =
      FirebaseRepository._privateConstructor();
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setData({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await _firestore
            .collection(collectionPath)
            .doc(documentId)
            .set(data, SetOptions(merge: true));
      } else {
        await _firestore.collection(collectionPath).add(data);
      }
    } on FirebaseException catch (e) {
      logg('Error setting data: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<void> updateData({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
    } on FirebaseException catch (e) {
      logg('Error updating data: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<void> deleteData({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } on FirebaseException catch (e) {
      logg('Error deleting data: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<DocumentSnapshot> getDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      return await _firestore.collection(collectionPath).doc(documentId).get();
    } on FirebaseException catch (e) {
      logg('Error getting document: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<List<DocumentSnapshot>> getCollection({
    required String collectionPath,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(collectionPath);
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }
      if (limit != null) {
        query = query.limit(limit);
      }
      QuerySnapshot querySnapshot = await query.get();
      return querySnapshot.docs;
    } on FirebaseException catch (e) {
      logg('Error getting collection: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Stream<QuerySnapshot> streamCollection({
    required String collectionPath,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    try {
      Query query = _firestore.collection(collectionPath);
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }
      if (limit != null) {
        query = query.limit(limit);
      }
      return query.snapshots();
    } on FirebaseException catch (e) {
      logg('Error streaming collection: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<void> batchUpdate(List<Map<String, dynamic>> updates) async {
    try {
      WriteBatch batch = _firestore.batch();
      for (var update in updates) {
        String collectionPath = update['collectionPath'] as String;
        String documentId = update['documentId'] as String;
        Map<String, dynamic> data = update['data'] as Map<String, dynamic>;
        batch.update(
            _firestore.collection(collectionPath).doc(documentId), data);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      logg('Error batch updating: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<void> batchDelete(List<Map<String, dynamic>> deletes) async {
    try {
      WriteBatch batch = _firestore.batch();
      for (var delete in deletes) {
        String collectionPath = delete['collectionPath'] as String;
        String documentId = delete['documentId'] as String;
        batch.delete(_firestore.collection(collectionPath).doc(documentId));
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      logg('Error batch deleting: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<List<DocumentSnapshot>> queryCollection({
    required String collectionPath,
    required List<QueryParameter> parameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(collectionPath);

      for (var param in parameters) {
        switch (param.queryType) {
          case QueryType.where:
            query = query.where(param.field, isEqualTo: param.value);
            break;
          case QueryType.whereGreater:
            query = query.where(param.field, isGreaterThan: param.value);
            break;
          case QueryType.whereLess:
            query = query.where(param.field, isLessThan: param.value);
            break;
          // Add more query types as needed (e.g., array contains, range queries)
        }
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }
      if (limit != null) {
        query = query.limit(limit);
      }

      QuerySnapshot querySnapshot = await query.get();
      return querySnapshot.docs;
    } on FirebaseException catch (e) {
      logg('Error querying collection: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<List<DocumentSnapshot>> searchCollection({
    required String collectionPath,
    required String field,
    required String searchText,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(collectionPath);

      query = query
          .where(field, isGreaterThanOrEqualTo: searchText)
          .where(field, isLessThanOrEqualTo: '$searchText\uf8ff');

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }
      if (limit != null) {
        query = query.limit(limit);
      }

      QuerySnapshot querySnapshot = await query.get();
      return querySnapshot.docs;
    } on FirebaseException catch (e) {
      logg('Error searching collection: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  Future<void> runTransaction({
    required String collectionPath,
    required String documentId,
    required Future<void> Function(DocumentSnapshot) transactionHandler,
  }) async {
    try {
      DocumentReference documentReference =
          _firestore.collection(collectionPath).doc(documentId);
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        await transactionHandler(snapshot);
      });
    } on FirebaseException catch (e) {
      logg('Error running transaction: $e', name: tag);
      throw UnhandledException(e.message);
    }
  }

  String getFirebaseExceptionMessage(FirebaseException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Your password is too weak. Please choose a stronger password.';
      case 'email-already-in-use':
        return 'The email address you entered is already in use. Please try a different email address.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'user-disabled':
        return 'The user account is disabled. Please contact support.';
      case 'wrong-password':
        return 'The email address or password is incorrect.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials. Please link or try signing in with the provider associated with the email address.';
      case 'invalid-credential':
        return 'The provided credential is invalid.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }
}

enum QueryType {
  where,
  whereGreater,
  whereLess,
  // Add more query types as needed
}

class QueryParameter {
  final QueryType queryType;
  final String field;
  final dynamic value;

  QueryParameter({
    required this.queryType,
    required this.field,
    required this.value,
  });
}
