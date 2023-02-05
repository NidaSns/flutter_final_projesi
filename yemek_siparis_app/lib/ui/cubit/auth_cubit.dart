import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../provider/http_exception.dart';

class AuthCubit extends Cubit<void> {
  AuthCubit() : super(<void>[]);

  String? _token;
  DateTime? _expiryDate = DateTime.now();
  String? _userId = "";

  bool get isAuth {
    return token != null ? true : false;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyB7H6-YjCSH4hpRwAwCjBS14O3GP5w0vA8');
    var veri = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    try {
      final response = await http.post(url, body: jsonEncode(veri));
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        _token = responseData['idToken'];
        _userId = responseData['localId'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              responseData['expiresIn'],
            ),
          ),
        );
      } else {
        if (responseData['error'] != null) {
          throw HttpException(responseData['error']['message']);
        }
        if (kDebugMode) {
          print(jsonDecode(response.body));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to create user.');
      }
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  bool logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    return isAuth;
  }

  // void _autoLogout() {
  //   final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //   Timer(Duration(seconds: timeToExpiry), logout);
  // }
}
