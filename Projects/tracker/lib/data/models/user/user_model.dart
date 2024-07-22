import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class AppUser {
  String? id;
  String? token;
  String? name;
  String? email;
  String? photoUrl;
  String? phoneNumber;
  String? authProviderName;

  AppUser(
      {this.id,
      this.name,
      this.email,
      this.token,
      this.photoUrl,
      this.phoneNumber,
      this.authProviderName});

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}