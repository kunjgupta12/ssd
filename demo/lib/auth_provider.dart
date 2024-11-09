import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Authprovider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(String email, String password) async {
    try {
      setloading(true);
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, "password": password});
      if (response.statusCode == 200) {
        setloading(false);
        print('success');
      } else
        setloading(false);
      print('error');
    } catch (e) {
      setloading(false);
      print(e.toString());
    }
  }
}
