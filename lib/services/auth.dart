import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:test/models/user.dart';
import 'package:test/services/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;

  late User _user;
  late String _token;

  String fou = "email already exist";

  late String test;

  final storage = new FlutterSecureStorage();

  bool get authenticated => _isLoggedIn;
  User get user => _user;

  void login({required Map creds}) async {
    print(creds);

    try {
      Dio.Response response = await dio().post('/auth/login', data: creds);
      // print(response.data.toString());
      String token = response.data.toString();
      tryToken(token: token);
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void tryToken({required String? token}) async {
    if (token == null) {
      return;
    } else {
      try {
        print("onest la " + token);
        Dio.Response response = await dio().get('/auth/user-profile',
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
        this._isLoggedIn = true;
        this._user = User.fromJson(response.data);
        this._token = token;
        this.storeToken(token: token);
        notifyListeners();
        // print(_user);
      } catch (e) {
        print(e);
      }
    }
  }

  void storeToken({required String token}) async {
    this.storage.write(key: 'token', value: token);
  }

  void logout() async {
    try {
      Dio.Response response = await dio().get('/user/revoke',
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));
      cleanUp();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void cleanUp() async {
    //  this._user = null;

    this._isLoggedIn = false;
    //   this._token = null;
    await storage.delete(key: 'token');
  }

  void register({required Map creds}) async {
    try {
      Dio.Response response = await dio().post('/auth/register', data: creds);

      //  print("TestT" + checkEmail.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getTest() {
    return test;
  }
}
