import 'user_model.dart';

class AuthResult {
  final bool success;
  String? message;
  final AuthUser? user;

  AuthResult.success([this.user, this.message]) : success = true;
  AuthResult.failure([this.message, this.user]) : success = false;

  AuthResult({required this.success, this.message = '', this.user});

  AuthResult copyWith({
    bool? success,
    String? message,
    AuthUser? user,
  }) {
    return AuthResult(
      success: success ?? this.success,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  AuthResult.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        message = json['message'],
        user = json['user'];

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': user,
    };
  }
}
