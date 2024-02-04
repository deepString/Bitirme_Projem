import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  
  loadUser() async {

    SharedPreferences storage = await SharedPreferences.getInstance();
    var id = storage.getInt("Id");
    var name = storage.getString("Name");
    var email = storage.getString("Email");

    // id eğer boşsa yani null ise oturum yok demektir
    // Oturumun olup olmadığını aşağıda kontrol ettim
    if (id == null) {
      return null;
    }
    else {
      return {"Id": id, "Name": name, "Email": email};
    }
  }

  saveUser({
    required int id,
    required String name,
    required String email,
  }) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt("Id", id);
    storage.setString("Name", name);
    storage.setString("Email", email);
  }

  // Aşağıdaki method kaydetmek için
  saveToken(String token) async {
    final storage = new FlutterSecureStorage();
    // SharedPreferences'te kaydetmek için set kullanmıştık. Burada ise write kullanıyoruz
    await storage.write(key: "token", value: token);
  }

  // Aşağıdaki method kaydettiğimiz bilgileri okumak için
  loadToken() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "token");
    return token;
  }

  clearUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final secureStorage = new FlutterSecureStorage();

    await storage.remove("Id");
    await storage.remove("Name");
    await storage.remove("Email");
    await secureStorage.delete(key: "token");
  }

}