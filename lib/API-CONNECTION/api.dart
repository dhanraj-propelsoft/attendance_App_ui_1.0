import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'http://192.168.1.88:80/api/';

  postData(data, apiUrl) async {
    print(data);
    print(apiUrl);

    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final value = localStorage.getString('token') ?? 0;
    var fullUrl = _url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $value'},
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_getToken()',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    return '?token=$token';
  }
}
