class LoginResponse {

  final String accessToken;
  final String tokenType;

  final bool requiresPasswordReset;

  final LoginUser user;

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.requiresPasswordReset,
    required this.user,
  });

  factory LoginResponse.fromJson(
      Map<String, dynamic> json,
      ) {

    return LoginResponse(

      accessToken:
      json["access_token"] ?? "",

      tokenType:
      json["token_type"] ?? "",

      requiresPasswordReset:
      json["requires_password_reset"] ?? false,

      user: LoginUser.fromJson(
        json["user"],
      ),
    );
  }
}

class LoginUser {

  final String id;

  final String fullName;

  final String mobileNumber;

  final String role;

  LoginUser({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.role,
  });

  factory LoginUser.fromJson(
      Map<String, dynamic> json,
      ) {

    return LoginUser(

      id: json["id"] ?? "",

      fullName:
      json["full_name"] ?? "",

      mobileNumber:
      json["mobile_number"] ?? "",

      role:
      json["role"] ?? "",
    );
  }
}