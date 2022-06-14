import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:minimal_app/global/global.dart';
import 'package:minimal_app/models/models.dart';

class ClientsService {

  Future<ClientListResponseModel> getClientPage({required int page}) async {

    final url = Uri.https(
      Environment.agencyCodaBaseUrl,
      '/client/list',
      {
        'page': '$page'       
      }
    );

    final response = await http.post(
      url,
    );

    if (response.statusCode == 200) {
      final clientListResponseModel = ClientListResponseModel.fromJson(response.body);
      return clientListResponseModel;
    } else {
      return ClientListResponseModel(
        success: false,
      );
    }
  }

  Future<ClientModel?> getClientByQuery({required String query}) async {

    final url = Uri.https(
      Environment.agencyCodaBaseUrl,
      '/client/fetch/$query'
    );

    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['response'] == null) return null;

      final clientModel = ClientModel.fromMap(data['response']);
      return clientModel;
    } else {
      return null;
    }
  }

}