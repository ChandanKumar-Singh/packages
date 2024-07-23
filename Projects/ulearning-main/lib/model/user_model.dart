// class User {
//   final String id;
//   final String email;
//   final String name;

//   User({required this.id, required this.email, required this.name});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       email: json['email'],
//       name: json['name'],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthUser {
//   final String primaryId;
//   final String uid;
//   final String? email;
//   final String? name;
//   final String? photoUrl;
//   final String? phoneNumber;

//   AuthUser({
//     required this.primaryId,
//     required this.uid,
//     this.email,
//     this.name,
//     this.photoUrl,
//     this.phoneNumber,
//   });

//   AuthUser copyWith({
//     String? primaryId,
//     String? uid,
//     String? email,
//     String? name,
//     String? photoUrl,
//     String? phoneNumber,
//   }) {
//     return AuthUser(
//       primaryId: primaryId ?? this.primaryId,
//       uid: uid ?? this.uid,
//       email: email ?? this.email,
//       name: name ?? this.name,
//       photoUrl: photoUrl ?? this.photoUrl,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//     );
//   }

//   AuthUser.fromJson(Map<String, dynamic> json)
//       : primaryId = json['primaryId'],
//         uid = json['uid'],
//         email = json['email'],
//         name = json['name'],
//         photoUrl = json['photoUrl'],
//         phoneNumber = json['phoneNumber'];

//   Map<String, dynamic> toJson() {
//     return {
//       'primaryId': primaryId,
//       'uid': uid,
//       'email': email,
//       'name': name,
//       'photoUrl': photoUrl,
//       'phoneNumber': phoneNumber,
//     };
//   }
// }

class AuthUser {
  String? primaryId; 
  String? uid; 
  String? email;
  String? name;
  String? photoUrl;
  bool? emailVerified;
  List<String>? roles;
  String? phoneNumber;
  String? createdAt;
  String? authProviderName;

  AuthUser({
    this.primaryId,
    this.uid,
    this.email,
    this.name,
    this.photoUrl,
    this.emailVerified,
    this.roles,
    this.phoneNumber,
    this.createdAt,
    this.authProviderName,
  });

  factory AuthUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data =
        doc.data() as Map<String, dynamic>?; // Use nullable map
    return AuthUser(
      primaryId: doc.id, // Using DocumentSnapshot id as primaryId
      uid:
          data?['uid'] as String?, // Fetch uid from Firestore data if available
      email: data?['email'] as String?,
      name: data?['displayName'] as String?,
      photoUrl: data?['photoUrl'] as String?,
      emailVerified: data?['emailVerified'] as bool?,
      roles:
          (data?['roles'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      phoneNumber: data?['phoneNumber'] as String?,
      createdAt: parseCreatedAt(data?['createdAt']),
      authProviderName: data?['authProviderName'] as String?,
    );
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      primaryId: map['primaryId'] as String?, // Fetch primaryId from map
      uid: map['uid'] as String?, // Fetch uid from map
      email: map['email'] as String?,
      name: map['displayName'] as String?,
      photoUrl: map['photoUrl'] as String?,
      emailVerified: map['emailVerified'] as bool?,
      roles:
          (map['roles'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      phoneNumber: map['phoneNumber'] as String?,
      createdAt: parseCreatedAt(map['createdAt']),
      authProviderName: map['authProviderName'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'primaryId': primaryId,
      'uid': uid,
      'email': email,
      'displayName': name,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
      'roles': roles,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'authProviderName': authProviderName,
    };
  }

  AuthUser copyWith({
    String? primaryId,
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? emailVerified,
    List<String>? roles,
    String? phoneNumber,
    String? createdAt,
    String? authProviderName,
  }) {
    return AuthUser(
      primaryId: primaryId ?? this.primaryId,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: displayName ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      roles: roles ?? this.roles,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      authProviderName: authProviderName ?? this.authProviderName,
    );
  }

  @override
  String toString() {
    return 'AuthUser{primaryId: $primaryId, uid: $uid, email: $email, displayName: $name, '
        'photoUrl: $photoUrl, emailVerified: $emailVerified, roles: $roles, '
        'phoneNumber: $phoneNumber, createdAt: $createdAt, authProviderName: $authProviderName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUser &&
          runtimeType == other.runtimeType &&
          primaryId == other.primaryId &&
          uid == other.uid &&
          email == other.email &&
          name == other.name &&
          photoUrl == other.photoUrl &&
          emailVerified == other.emailVerified &&
          roles == other.roles &&
          phoneNumber == other.phoneNumber &&
          createdAt == other.createdAt &&
          authProviderName == other.authProviderName;

  @override
  int get hashCode =>
      primaryId.hashCode ^
      uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      photoUrl.hashCode ^
      emailVerified.hashCode ^
      roles.hashCode ^
      phoneNumber.hashCode ^
      createdAt.hashCode ^
      authProviderName.hashCode;
}

String? parseCreatedAt(dynamic data) {
  if (data is Timestamp) {
    return data.toDate().toIso8601String();
  } else if (data is DateTime) {
    return data.toIso8601String();
  }
  return null;
}
