import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final String baseUrl = 'http://10.0.2.2:3000/api';
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class AuthServices {

  Future<void> login(String email, String password) async{
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: { 'Content-type': 'application/json' },
      body: jsonEncode({
        'email': email,
        'password': password
      })
    );
    
    final data = await jsonDecode(response.body);
    if(response.statusCode == 200){
      final prefs = await SharedPreferences.getInstance();
      final dataUser = data['datas'];
      await prefs.setString('iduser', dataUser['iduser']);
      await prefs.setString('email', dataUser['email']);
      await prefs.setString('name', dataUser['name']);
      await prefs.setString('role', dataUser['role']);
      await prefs.setBool('isLoggedIn', true);
      await secureStorage.write(key: 'token', value: data['token']);
      return data['message'];
    }else{
      return data['message'] ?? 'Login failed';
    }
  }

  Future<void> register(String name, String email, String password) async{

  }

  Future<void> logout() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await secureStorage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await secureStorage.read(key: 'token');
    return prefs.getBool('isLoggedIn') == true && token != null;
  }

}