import 'dart:convert';

class ClientListResponseModel {
  ClientListResponseModel({
    required this.success,
    this.response,
  });

  final bool success;
  final ResponseClientList? response;

  ClientListResponseModel copyWith({
    bool? success,
    ResponseClientList? response,
  }) => ClientListResponseModel(
    success: success ?? this.success,
    response: response ?? this.response,
  );

  factory ClientListResponseModel.fromJson(String str) => ClientListResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClientListResponseModel.fromMap(Map<String, dynamic> json) => ClientListResponseModel(
    success: json["success"],
    response: json["response"] == null ? null : ResponseClientList.fromMap(json["response"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "response": response?.toMap(),
  };

}

class ResponseClientList {

  ResponseClientList({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
  });

  final int currentPage;
  final List<ClientModel> data;
  final int from;
  final int lastPage;

  ResponseClientList copyWith({
    int? currentPage,
    List<ClientModel>? data,
    int? from,
    int? lastPage,
  }) => ResponseClientList(
    currentPage: currentPage ?? this.currentPage,
    data: data ?? this.data,
    from: from ?? this.from,
    lastPage: lastPage ?? this.lastPage,
  );

  factory ResponseClientList.fromJson(String str) => ResponseClientList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseClientList.fromMap(Map<String, dynamic> json) => ResponseClientList(
    currentPage: json["current_page"],
    data: List<ClientModel>.from(json["data"].map((x) => ClientModel.fromMap(x))),
    from: json["from"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "from": from,
    "last_page": lastPage,
  };

}

class ClientModel {
  ClientModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.photo,
    required this.caption,
  });

  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String address;
  final String photo;
  final String caption;

  ClientModel copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? address,
    String? photo,
    String? caption,
  }) => ClientModel(
    id: id ?? this.id,
    firstname: firstname ?? this.firstname,
    lastname: lastname ?? this.lastname,
    email: email ?? this.email,
    address: address ?? this.address,
    photo: photo ?? this.photo,
    caption: caption ?? this.caption,
  );

  factory ClientModel.fromJson(String str) => ClientModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClientModel.fromMap(Map<String, dynamic> json) => ClientModel(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    address: json["address"],
    photo: json["photo"],
    caption: json["caption"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "address": address,
    "photo": photo,
    "caption": caption,
  };
}
