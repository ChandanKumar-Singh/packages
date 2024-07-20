import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AppUser {
  String? id;
  String? name;
  String? email;
  String? password;

  AppUser({this.id, this.name, this.email, this.password});
}
