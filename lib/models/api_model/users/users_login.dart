import 'package:freezed_annotation/freezed_annotation.dart';
part 'users_login.freezed.dart';
part 'users_login.g.dart';

@freezed
class UserLogin with _$UserLogin {
  factory UserLogin({
    required String access_token,
  }) = _UserLogin;

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);
}

