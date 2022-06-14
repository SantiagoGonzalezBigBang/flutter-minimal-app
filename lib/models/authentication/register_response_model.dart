import 'dart:convert';

import 'package:minimal_app/models/models.dart';

class RegisterResponseModel {
  RegisterResponseModel({
    required this.success,
    this.response,
    this.errorModel
  });

  final bool success;
  final ResponseRegister? response;
  final ErrorAuthenticationModel? errorModel;

  RegisterResponseModel copyWith({
    bool? success,
    ResponseRegister? response,
    ErrorAuthenticationModel? errorModel
  }) => RegisterResponseModel(
    success : success ?? this.success,
    response: response ?? this.response,
    errorModel: errorModel ?? this.errorModel,
  );

  factory RegisterResponseModel.fromJson(String str) => RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) => RegisterResponseModel(
    success   : json["success"],
    response  : json["response"] == null ? null : ResponseRegister.fromMap(json["response"]),
    errorModel: json["error"] == null ? null : ErrorAuthenticationModel.fromMap(json["error"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "response": response?.toMap(),
    "error": errorModel?.toMap(),
  };
}

class ResponseRegister {
  ResponseRegister({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.photo,
    required this.role,
    required this.id,
  });

  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String photo;
  final int role;
  final int id;

  ResponseRegister copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? photo,
    int? role,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) => ResponseRegister(
    firstname: firstname ?? this.firstname,
    lastname: lastname ?? this.lastname,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    photo: photo ?? this.photo,
    role: role ?? this.role,
    id: id ?? this.id,
  );

  factory ResponseRegister.fromJson(String str) => ResponseRegister.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseRegister.fromMap(Map<String, dynamic> json) => ResponseRegister(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    role: json["role"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "photo": photo,
    "role": role,
    "id": id,
  };
}