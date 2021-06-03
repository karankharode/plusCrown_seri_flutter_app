import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class UserToSave {
  final String id;
  final String email;
  final String phoneNo;
  final String password;
  final bool status;
  final bool isAdmin;
  final String refresh;
  final String access;
  final String loggedIn;

  UserToSave(
      {this.id,
      this.email,
      this.phoneNo,
      this.password,
      this.status,
      this.isAdmin,
      this.refresh,
      this.access,
      this.loggedIn});

  factory UserToSave.fromJson(Map<String, dynamic> parsedJson) {
    return new UserToSave(
      id: parsedJson['id'] ?? "",
      email: parsedJson['email'] ?? "",
      phoneNo: parsedJson['phoneNo'] ?? "",
      password: parsedJson['password'] ?? "",
      status: parsedJson['status'] ?? "",
      isAdmin: parsedJson['isAdmin'] ?? "",
      refresh: parsedJson['refresh'] ?? "",
      access: parsedJson['access'] ?? "",
      loggedIn: parsedJson['loggedIn'] ?? "",
    );
  }

  Map<String, dynamic> toJson(LoginResponse loginResponse) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return {
      data["id"]: loginResponse.id,
      data["email"]: this.email,
      data["phoneNo"]: this.phoneNo,
      data["password"]: this.password,
      data["status"]: loginResponse.status,
      data["isAdmin"]: loginResponse.isAdmin,
      data["refresh"]: loginResponse.refresh,
      data["access"]: loginResponse.access,
      data["loggedIn"]: loginResponse.loggedIn,
    };
  }
}
