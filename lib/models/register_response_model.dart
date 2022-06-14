import 'dart:convert';

class RegisterResponseModel {
  RegisterResponseModel({
    required this.success,
    this.response,
    this.errorModel
  });

  final bool success;
  final Response? response;
  final ErrorRegisterModel? errorModel;

  RegisterResponseModel copyWith({
    bool? success,
    Response? response,
    ErrorRegisterModel? errorModel
  }) => RegisterResponseModel(
    success : success ?? this.success,
    response: response ?? this.response,
    errorModel: errorModel ?? this.errorModel,
  );

  factory RegisterResponseModel.fromJson(String str) => RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) => RegisterResponseModel(
    success   : json["success"],
    response  : json["response"] == null ? null : Response.fromMap(json["response"]),
    errorModel: json["error"] == null ? null : ErrorRegisterModel.fromMap(json["error"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "response": response?.toMap(),
    "error": errorModel?.toMap(),
  };
}

class Response {
  Response({
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

  Response copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? photo,
    int? role,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) => Response(
    firstname: firstname ?? this.firstname,
    lastname: lastname ?? this.lastname,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    photo: photo ?? this.photo,
    role: role ?? this.role,
    id: id ?? this.id,
  );

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => Response(
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

class ErrorRegisterModel {
  ErrorRegisterModel({
    required this.code,
    required this.message,
  });

  final int code;
  final String message;

  ErrorRegisterModel copyWith({
    int? code,
    String? message,
  }) => ErrorRegisterModel(
    code: code ?? this.code,
    message: message ?? this.message,
  );

  factory ErrorRegisterModel.fromJson(String str) => ErrorRegisterModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorRegisterModel.fromMap(Map<String, dynamic> json) => ErrorRegisterModel(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "message": message,
  };
}
