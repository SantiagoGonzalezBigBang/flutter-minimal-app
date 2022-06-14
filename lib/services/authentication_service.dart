import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:minimal_app/global/global.dart';
import 'package:minimal_app/models/models.dart';

class AuthenticationService {

  Future<LoginResponseModel> logIn({required String email, required String password}) async {

    final data = {
      'email'    : email,
      'password' : password
    };

    final url = Uri.https(
      Environment.agencyCodaBaseUrl, 
      '/mia-auth/login',
    );

    final response = await http.post(
      url, 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    if (response.statusCode == 200) {
      final loginResponseModel = LoginResponseModel.fromJson(response.body);
      return loginResponseModel;
    } else {
      return LoginResponseModel(
        success: false,
        errorModel: ErrorAuthenticationModel(
          code: 0,
          message: 'An error has occurred'
        )
      );
    }
  }

  Future<RegisterResponseModel> signUp({required String email, required String password}) async {

    final data = {
      'email'    : email,
      'password' : password
    };

    final url = Uri.https(
      Environment.agencyCodaBaseUrl, 
      '/mia-auth/register',
    );

    final response = await http.post(
      url, 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    if (response.statusCode == 200) {
      final registerResponseModel = RegisterResponseModel.fromJson(response.body);
      return registerResponseModel;
    } else {
      return RegisterResponseModel(
        success: false,
        errorModel: ErrorAuthenticationModel(
          code: 0,
          message: 'An error has occurred'
        )
      );
    }
  }

}