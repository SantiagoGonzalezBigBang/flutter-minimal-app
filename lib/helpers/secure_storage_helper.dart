import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {

  final _flutterSecureStorage = const FlutterSecureStorage();

  //* Write
  Future writeToken(String token) async {
    return await _flutterSecureStorage.write(key: 'token', value: token);
  }

  Future writeEmail(String email) async {
    return await _flutterSecureStorage.write(key: 'email', value: email);
  }

  Future writePassword(String password) async {
    return await _flutterSecureStorage.write(key: 'password', value: password);
  }


  //* Delete
  Future deleteToken() async {
    await _flutterSecureStorage.delete(key: 'token');
  }

  Future deleteEmail() async {
    await _flutterSecureStorage.delete(key: 'email');
  }

  Future deletePassword() async {
    await _flutterSecureStorage.delete(key: 'password');
  }

  //* Read
  Future<String?> readToken() async {
    return await _flutterSecureStorage.read(key: 'token');
  }

  Future<String?> readEmail() async {
    return await _flutterSecureStorage.read(key: 'email');
  }

  Future<String?> readPassword() async {
    return await _flutterSecureStorage.read(key: 'password');
  }

}