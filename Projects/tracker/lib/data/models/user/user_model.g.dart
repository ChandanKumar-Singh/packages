// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      photoUrl: json['photoUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'phoneNumber': instance.phoneNumber,
    };
