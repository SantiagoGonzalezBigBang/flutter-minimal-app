import 'dart:convert';

import 'package:minimal_app/models/models.dart';

class LoginResponseModel {
  LoginResponseModel({
    required this.success,
    this.response,
    this.errorModel
  });

  final bool success;
  final ResponseLogin? response;
  final ErrorAuthenticationModel? errorModel;

  LoginResponseModel copyWith({
    bool? success,
    ResponseLogin? response,
    ErrorAuthenticationModel? errorModel
  }) => LoginResponseModel(
    success: success ?? this.success,
    response: response ?? this.response,
    errorModel: errorModel ?? this.errorModel,
  );

  factory LoginResponseModel.fromJson(String str) => LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) => LoginResponseModel(
    success   : json["success"],
    response  : json["response"] == null ? null : ResponseLogin.fromMap(json["response"]),
    errorModel: json["error"] == null ? null : ErrorAuthenticationModel.fromMap(json["error"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "response": response?.toMap(),
    "error": errorModel?.toMap(),
  };
}

class ResponseLogin {

  ResponseLogin({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.photo,
    required this.phone,
    required this.role,
    required this.accessToken,
  });

  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String photo;
  final String phone;
  final int role;
  final String accessToken;

  ResponseLogin copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? photo,
    String? phone,
    int? role,
    String? accessToken,
  }) => ResponseLogin(
    id: id ?? this.id,
    firstname: firstname ?? this.firstname,
    lastname: lastname ?? this.lastname,
    email: email ?? this.email,
    photo: photo ?? this.photo,
    phone: phone ?? this.phone,
    role: role ?? this.role,
    accessToken: accessToken ?? this.accessToken,
  );

  factory ResponseLogin.fromJson(String str) => ResponseLogin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseLogin.fromMap(Map<String, dynamic> json) => ResponseLogin(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    photo: json["photo"],
    phone: json["phone"],
    role: json["role"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "photo": photo,
    "phone": phone,
    "role": role,
    "access_token": accessToken,
  };
}