import 'package:dio/dio.dart';

class LoginResponse {
  final int id;
  final String email;
  final String phoneNo;
  final String password;
  final bool status;
  final bool isAdmin;
  final String refresh;
  final String access;
  final String loggedIn;
  final String pincode;
  // ignore: non_constant_identifier_names
  final String Firstname;
  // ignore: non_constant_identifier_names
  final String Lastname;

  LoginResponse(
      {this.id,
      this.email,
      this.phoneNo,
      this.password,
      this.status,
      this.isAdmin,
      this.refresh,
      this.access,
      this.loggedIn,
      this.pincode,
      // ignore: non_constant_identifier_names
      this.Firstname,
      // ignore: non_constant_identifier_names
      this.Lastname});

  factory LoginResponse.getLoginResponseFromHttpResponse(
      Response<dynamic> response, String email, String password, String phoneNo) {
    return LoginResponse(
        email: email,
        password: password,
        phoneNo: phoneNo,
        status: response.data['status'],
        isAdmin: response.data['is_admin'],
        refresh: response.data['refresh'],
        access: response.data['access'],
        loggedIn: response.data['loggedIn'] ?? "",
        id: response.data['id'],
        Firstname: response.data['Firstname'],
        Lastname: response.data['Lastname'],
        pincode: response.data['pincode']);
  }

  factory LoginResponse.getUserDetailsLoginResponseFromHttpResponse(Response<dynamic> response) {
    return LoginResponse(
        email: response.data['Email'],
        password: response.data['Password'],
        phoneNo: response.data['Phone'],
        status: response.data['status'],
        isAdmin: response.data['is_admin'],
        refresh: response.data['refresh'] ?? "",
        access: response.data['access'] ?? "",
        loggedIn: response.data['loggedIn'] ?? "",
        id: response.data['id'],
        Firstname: response.data['Firstname'],
        Lastname: response.data['Lastname'],
        pincode: response.data['pincode']);
  }

  factory LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return new LoginResponse(
        id: parsedJson['id'] ?? "",
        email: parsedJson['Email'] ?? "",
        phoneNo: parsedJson['Phone'] ?? "",
        password: parsedJson['Password'] ?? "",
        status: parsedJson['status'] ?? "",
        isAdmin: parsedJson['isAdmin'],
        refresh: parsedJson['refresh'] ?? "",
        access: parsedJson['access'] ?? "",
        loggedIn: parsedJson['loggedIn'] ?? "",
        Firstname: parsedJson['Firstname'] ?? "",
        Lastname: parsedJson['Lastname'] ?? "",
        pincode: parsedJson['pincode'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return {
      data["Email"]: this.email,
      data["Phone"]: this.phoneNo,
      data["Password"]: this.password,
      data["status"]: this.status,
      data["isAdmin"]: this.isAdmin,
      data["refresh"]: this.refresh,
      data["access"]: this.access,
      data["loggedIn"]: this.loggedIn,
      data["id"]: this.id,
      data["Firstname"]: this.Firstname,
      data["Lastname"]: this.Lastname,
      data["pincode"]: this.pincode,
    };
  }
}
