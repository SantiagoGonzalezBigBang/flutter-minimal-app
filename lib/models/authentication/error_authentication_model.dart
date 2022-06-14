import 'dart:convert';

class ErrorAuthenticationModel {
  ErrorAuthenticationModel({
    required this.code,
    required this.message,
  });

  final int code;
  final String message;

  ErrorAuthenticationModel copyWith({
    int? code,
    String? message,
  }) => ErrorAuthenticationModel(
    code: code ?? this.code,
    message: message ?? this.message,
  );

  factory ErrorAuthenticationModel.fromJson(String str) => ErrorAuthenticationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorAuthenticationModel.fromMap(Map<String, dynamic> json) => ErrorAuthenticationModel(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
  };
}